//
//  SlideSwitchAdjustScreen+Nav.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/2/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SlideSwitchAdjustScreenDemo2.h"
#import "TestViewController.h"
#import "XLSlideSwitch.h"

@interface SlideSwitchAdjustScreenDemo2 ()<XLSlideSwitchDelegate>
{
    XLSlideSwitch *_slideSwitch;
}
@end

@implementation SlideSwitchAdjustScreenDemo2

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
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _slideSwitch.delegate = self;
    _slideSwitch.btnSelectedColor = RedColor;
    _slideSwitch.btnNormalColor = GrayColor;
    _slideSwitch.viewControllers = viewControllers;
    //设置适配屏幕宽度属性为真
    _slideSwitch.adjustBtnSize2Screen = true;
    //显示在viewcontroller的navigationBar上
    [_slideSwitch showsInNavBarOf:self];
    //设置隐藏阴影
    _slideSwitch.hideShadow = true;
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
