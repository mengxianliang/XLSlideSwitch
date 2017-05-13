//
//  SegmentedSlideSwitchExample2.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SegmentedSlideSwitchExample2.h"
#import "TestViewController.h"
#import "XLSegmentedSlideSwitch.h"
#import "PushTestViewController.h"

@interface SegmentedSlideSwitchExample2 ()<XLSlideSwitchDelegate>
{
    XLSegmentedSlideSwitch *_slideSwitch;
}
@end

@implementation SegmentedSlideSwitchExample2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSArray *titles = @[@"今天",@"是个",@"好日子"];
    for (int i = 0 ; i<titles.count; i++) {
        TestViewController *vc = [TestViewController new];
        vc.title = titles[i];
        [viewControllers addObject:vc];
    }
    _slideSwitch = [[XLSegmentedSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) Titles:titles viewControllers:viewControllers];
    _slideSwitch.delegate = self;
    _slideSwitch.tintColor = RedColor;
    [_slideSwitch showInNavigationController:self.navigationController];
}

#pragma mark -
#pragma mark SlideSwitchDelegate
-(void)slideSwitchDidselectAtIndex:(NSUInteger)index{
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
