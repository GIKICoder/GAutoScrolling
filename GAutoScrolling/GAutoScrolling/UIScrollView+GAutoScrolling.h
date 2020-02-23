//
//  UIScrollView+GAutoScrolling.h
//  GAutoScrolling
//
//  Created by GIKI on 2020/2/23.
//  Copyright © 2020 GIKI. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UIScrollViewAutoDirection) {
    UIScrollViewAutoDirectionVertical,
    UIScrollViewAutoDirectionHorizontal,
};

@interface UIScrollView (GAutoScrolling)

@property (nonatomic) CGFloat scrollPointsPerSecond;
@property (nonatomic, getter = isScrolling) BOOL scrolling;
/// 0 is no limt
@property (nonatomic, assign) NSInteger  repeat;

@property (nonatomic, assign) UIScrollViewAutoDirection  autoDirection;

- (void)startScrolling;
- (void)stopScrolling;

@end

NS_ASSUME_NONNULL_END
