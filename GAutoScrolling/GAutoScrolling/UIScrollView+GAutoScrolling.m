//
//  UIScrollView+GAutoScrolling.m
//  GAutoScrolling
//
//  Created by GIKI on 2020/2/23.
//  Copyright © 2020 GIKI. All rights reserved.
//

#import "UIScrollView+GAutoScrolling.h"
#import <objc/runtime.h>
#import <QuartzCore/CADisplayLink.h>

static CGFloat UIScrollViewDefaultScrollPointsPerSecond = 15.0f;
static char UIScrollViewScrollPointsPerSecondNumber;
static char UIScrollViewAutoScrollDisplayLink;
static char UIScrollViewAutoScrollRepeat;
static char UIScrollViewAutoScrollRepeatCount;
static char UIScrollViewAutoScrollDirection;

@interface UIScrollView (GAutoScrolling_Internal)

@property (nonatomic, assign) NSInteger  repeat_count;
@property (nonatomic, strong) CADisplayLink *autoScrollDisplayLink;

@end

@implementation UIScrollView (GAutoScrolling)

- (void)startScrolling
{
    [self stopScrolling];
    self.repeat_count = 1;
    self.autoScrollDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_displayTick:)];
    [self.autoScrollDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopScrolling
{
    [self.autoScrollDisplayLink invalidate];
    self.autoScrollDisplayLink = nil;
}

- (void)_displayTick:(CADisplayLink *)displayLink
{
    if (self.window == nil) {
        [self stopScrolling];
    }
    if (self.autoDirection == UIScrollViewAutoDirectionVertical) {
        [self autoDirectionVertical:displayLink];
    } else {
        [self autoDirectionHorizontal:displayLink];
    }
    
}

- (void)autoDirectionHorizontal:(CADisplayLink *)displayLink
{
    CGFloat animationDuration = displayLink.duration;
    CGFloat pointChange = self.scrollPointsPerSecond * animationDuration;
    CGPoint newOffset = (CGPoint) {
        .x = self.contentOffset.x - pointChange,
        .y = self.contentOffset.y
    };
    CGFloat maximumXOffset = self.contentSize.width - self.bounds.size.width;
    if (newOffset.x > maximumXOffset) {
        if (self.repeat == 0 || self.repeat_count < self.repeat) {
            [self setContentOffset:CGPointMake(0, 0) animated:NO];
            self.repeat_count ++;
        } else {
            [self stopScrolling];
        }
    } else {
        self.contentOffset = newOffset;
    }
}

- (void)autoDirectionVertical:(CADisplayLink *)displayLink
{
    CGFloat animationDuration = displayLink.duration;
    CGFloat pointChange = self.scrollPointsPerSecond * animationDuration;
    CGPoint newOffset = (CGPoint) {
        .x = self.contentOffset.x,
        .y = self.contentOffset.y + pointChange
    };
    CGFloat maximumYOffset = self.contentSize.height - self.bounds.size.height;
    if (newOffset.y > maximumYOffset) {
        if (self.repeat == 0 || self.repeat_count < self.repeat) {
            [self setContentOffset:CGPointMake(0, 0) animated:NO];
            self.repeat_count ++;
        } else {
            [self stopScrolling];
        }
    } else {
        self.contentOffset = newOffset;
    }
}

#pragma mark - Property Methods

- (void)setScrolling:(BOOL)scrolling
{
    if (scrolling) {
        [self startScrolling];
    } else {
        [self stopScrolling];
    }
}

- (BOOL)isScrolling
{
    return (self.autoScrollDisplayLink != nil);
}

- (UIScrollViewAutoDirection)autoDirection
{
    NSNumber *scrollAutoDirection = objc_getAssociatedObject(self, &UIScrollViewAutoScrollDirection);
    if (scrollAutoDirection) {
        return [scrollAutoDirection integerValue];
    } else {
        return UIScrollViewAutoDirectionVertical;
    }
}

- (void)setAutoDirection:(UIScrollViewAutoDirection)autoDirection
{
    [self willChangeValueForKey:@"autoDirection"];
    objc_setAssociatedObject(self,
                             &UIScrollViewAutoScrollDirection,
                             [NSNumber numberWithInteger:autoDirection],
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"autoDirection"];
}

- (NSInteger)repeat_count
{
    NSNumber *scrollPointsRepeatNumber = objc_getAssociatedObject(self, &UIScrollViewAutoScrollRepeatCount);
    if (scrollPointsRepeatNumber) {
        return [scrollPointsRepeatNumber integerValue];
    } else {
        return 1;
    }
}

- (void)setRepeat_count:(NSInteger)repeat_count
{
    [self willChangeValueForKey:@"repeat_count"];
    objc_setAssociatedObject(self,
                             &UIScrollViewAutoScrollRepeatCount,
                             [NSNumber numberWithInteger:repeat_count],
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"repeat_count"];
}

- (NSInteger)repeat
{
    NSNumber *scrollPointsRepeatNumber = objc_getAssociatedObject(self, &UIScrollViewAutoScrollRepeat);
    if (scrollPointsRepeatNumber) {
        return [scrollPointsRepeatNumber integerValue];
    } else {
        return 1;
    }
}

- (void)setRepeat:(NSInteger)repeat
{
    if (repeat == NSIntegerMax) {
        repeat = 0;
    }
    [self willChangeValueForKey:@"repeat"];
    objc_setAssociatedObject(self,
                             &UIScrollViewAutoScrollRepeat,
                             [NSNumber numberWithInteger:repeat],
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"repeat"];
}

- (CGFloat)scrollPointsPerSecond
{
    NSNumber *scrollPointsPerSecondNumber = objc_getAssociatedObject(self, &UIScrollViewScrollPointsPerSecondNumber);
    if (scrollPointsPerSecondNumber) {
        return [scrollPointsPerSecondNumber floatValue];
    } else {
        return UIScrollViewDefaultScrollPointsPerSecond;
    }
}

- (void)setScrollPointsPerSecond:(CGFloat)scrollPointsPerSecond
{
    [self willChangeValueForKey:@"scrollPointsPerSecond"];
    objc_setAssociatedObject(self,
                             &UIScrollViewScrollPointsPerSecondNumber,
                             [NSNumber numberWithFloat:scrollPointsPerSecond],
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"scrollPointsPerSecond"];
}

- (CADisplayLink *)autoScrollDisplayLink
{
    return objc_getAssociatedObject(self, &UIScrollViewAutoScrollDisplayLink);
}

- (void)setAutoScrollDisplayLink:(CADisplayLink *)autoScrollDisplayLink
{
    [self willChangeValueForKey:@"autoScrollDisplayLink"];
    objc_setAssociatedObject(self,
                             &UIScrollViewAutoScrollDisplayLink,
                             autoScrollDisplayLink,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"autoScrollDisplayLink"];
}

@end
