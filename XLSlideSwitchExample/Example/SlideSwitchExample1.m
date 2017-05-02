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

@interface SlideSwitchExample1 ()<XLSlideSwitchDelegate,TestViewControllerDelegate>
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
    
    //创建需要展示的ViewController
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    for (int i = 0 ; i<titles.count; i++) {
        TestViewController *vc = [TestViewController new];
        vc.title = titles[i];
        vc.delegate = self;
        [viewControllers addObject:vc];
    }
    //创建滚动视图
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = RedColor;
    _slideSwitch.itemNormalColor = GrayColor;
    //设置要显示的视图集合
    _slideSwitch.viewControllers = viewControllers;
    //设置标题
    _slideSwitch.titles = titles;
    [self.view addSubview:_slideSwitch];
}

#pragma mark -
#pragma mark SlideSwitchDelegate

-(void)slideSwitchDidselectTab:(NSUInteger)index{
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}

#pragma mark -
#pragma mark TestViewControllerDelegate

-(void)testTableViewDidClickAt:(NSIndexPath *)indexPath
{
    PushTestViewController *pushVC = [[PushTestViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
