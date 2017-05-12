//
//  SlideSwitchExample1.m
//  XLSlideSwitchExample
//
//  Created by MengXianLiang on 2017/5/2.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "SlideSwitchExample1.h"
#import "TestViewController.h"
#import "XLSlideSwitch.h"
#import "PushTestViewController.h"

@interface SlideSwitchExample1 ()<XLSlideSwitchDelegate>
{
    XLSlideSwitch *_slideSwitch;
}
@end

@implementation SlideSwitchExample1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //要显示的标题
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    //创建需要展示的ViewController
    NSMutableArray *viewControllers = [NSMutableArray new];
    for (int i = 0 ; i<titles.count; i++) {
        TestViewController *vc = [TestViewController new];
        vc.title = titles[i];
        [viewControllers addObject:vc];
    }
    //创建滚动视图
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) Titles:titles viewControllers:viewControllers selectedIndex:2];
    
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = RedColor;
    _slideSwitch.itemNormalColor = GrayColor;
    //显示方法
    [_slideSwitch showInViewController:self];
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
