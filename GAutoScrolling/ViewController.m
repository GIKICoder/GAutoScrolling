//
//  ViewController.m
//  GAutoScrolling
//
//  Created by GIKI on 2020/2/23.
//  Copyright © 2020 GIKI. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+GAutoScrolling.h"
@interface ViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView * textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200) textContainer:nil];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    self.textView.text = @"防控工作取得阶段性成效，但全国疫情发展拐点尚未到来——中共中央政治局会议作出的判断表明，“战疫”仍“吃劲”，远远不能松劲。而在第一季度已经过半、全年即将过去六分之一的当下，有序推动复工复产，畅通经济社会循环，尽可能将疫情对经济社会发展的影响降到最低，也是“战役”，一样“吃劲”。一手抓防控，这是“硬任务”；一手抓发展，这是“硬道理”。两手都要硬，就很考验统筹兼顾的水平。　不久前的中央政治局常委会会议特别提出，面对眼前这场大考，各级领导干部必须有“统筹兼顾之谋”。这首先是一种意识，一种讲究全面、辩证的思想自觉——不能因为防疫任务吃紧，就坐视发展停滞，甚至对此心安理得；也不能因为急着复工复产，就对防疫产生懈怠，甚至纵容盲目乐观。　善统筹、能兼顾，也考验对方方面面问题的判断力、执行力。用市委防控工作领导小组会议上的话说，疫情防控要突出“时度效”，“六稳”工作要突出“早准实”。出的判断表明，“战疫”仍“吃劲”，远远不能松劲。而在第一季度已经过半、全年即将过去六分之一的当下，有序推动复工复产，畅通经济社会循环，尽可能将疫情对经济社会发展的影响降到最低，也是“战役”，一样“吃劲”。一手抓防控，这是“硬任务”；一手抓发展，这是“硬道理”。两手都要硬，就很考验统筹兼顾的水平。　不久前的中央政治局常委会会议特别提出，面对眼前这场大考，各级领导干部必须有“统筹兼顾之谋”。这首先是一种意识，一种讲究全面、辩证的思想自觉——不能因为防疫任务吃紧，就坐视发展停滞，甚至对此心安理得；也不能因为急着复工复产，就对防疫产生懈怠，甚至纵容盲目乐观。　善统筹、能兼顾，12也考验对方方面面问题的判断力、执行力。用市委防控工作领导小组会议上的话说，疫情防控要突出“时度效”，“六稳”工作要突出“早准实”。这首先是一种12意识，一种讲究全面、辩证的思想自觉——不能因为防疫任务吃紧，就坐视发展停滞，甚至对此心安理得；也不能因为急着复工复产，就对防疫产生懈怠，甚至纵容盲目乐观。　善统筹、能兼顾，也考验对方方面面问题的判断力、执行力。用市委防控工作领导小组";
     self.textView.repeat = 2;
     [self.textView startScrolling];
}

- (void)textViewDidBeginEditing:(UITextView *)aTextView
{
    [self.textView stopScrolling];
}

- (void)textViewDidEndEditing:(UITextView *)aTextView
{
    [self.textView startScrolling];
}

- (BOOL)textView:(UITextView *)aTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate && !self.textView.isFirstResponder) {
        [self.textView startScrolling];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!self.textView.isFirstResponder) {
        [self.textView startScrolling];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
