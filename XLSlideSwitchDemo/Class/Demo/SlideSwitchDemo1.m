//
//  XLSlideSwitchViewController.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SlideSwitchDemo1.h"
#import "TestViewController.h"
#import "XLSlideSwitch.h"

@interface SlideSwitchDemo1 ()<XLSlideSwitchDelegate>
{
    XLSlideSwitch *_slideSwitch;
}
@end

@implementation SlideSwitchDemo1


- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    if (_adjustScreen) {
        titles = @[@"今天",@"是个",@"好日子"];
    }
    for (int i = 0 ; i<titles.count; i++) {
        TestViewController *vc = [TestViewController new];
        vc.title = titles[i];
        [viewControllers addObject:vc];
    }
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _slideSwitch.delegate = self;
    _slideSwitch.btnSelectedColor = RedColor;
    _slideSwitch.btnNormalColor = GrayColor;
    _slideSwitch.adjustBtnSize2Screen = true;
    _slideSwitch.viewControllers = viewControllers;
    _slideSwitch.adjustBtnSize2Screen = _adjustScreen;
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
