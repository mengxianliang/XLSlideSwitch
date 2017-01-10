//
//  XLSegmentSlideSwitchShowsInNavVC.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SegmentedSlideSwitchDemo2.h"
#import "TestViewController.h"
#import "XLSegmentedSlideSwitch.h"

@interface SegmentedSlideSwitchDemo2 ()<XLSlideSwitchDelegate>
{
    XLSegmentedSlideSwitch *_slideSwitch;
}
@end

@implementation SegmentedSlideSwitchDemo2

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
    _slideSwitch = [[XLSegmentedSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _slideSwitch.delegate = self;
    _slideSwitch.tintColor = RedColor;
    _slideSwitch.viewControllers = viewControllers;
    [_slideSwitch showsInNavBarOf:self];
    [self.view addSubview:_slideSwitch];
}

#pragma mark -
#pragma mark SlideSwitchDelegate

-(void)slideSwitchDidselectTab:(NSUInteger)index
{
    //可以通过viewWillAppear方法加载数据
    UIViewController * vc = _slideSwitch.viewControllers[index];
    [vc viewWillAppear:YES];
}

-(void)slideSwitchPanLeftEdge:(UIPanGestureRecognizer *)panParam
{
    NSLog(@"滑动到左边缘，可以处理滑动返回等一些问题");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
