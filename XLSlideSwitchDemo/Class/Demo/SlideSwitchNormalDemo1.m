//
//  SlideSwitchNormal.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/2/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SlideSwitchNormalDemo1.h"
#import "TestViewController.h"
#import "XLSlideSwitch.h"
#import "PushTestViewController.h"

@interface SlideSwitchNormalDemo1 ()<XLSlideSwitchDelegate,TestViewControllerDelegate>
{
    XLSlideSwitch *_slideSwitch;
}
@end

@implementation SlideSwitchNormalDemo1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建需要展示的ViewController
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    for (int i = 0 ; i<titles.count; i++) {
        TestViewController *vc = [TestViewController new];
        vc.title = titles[i];
        vc.delegate = self;
        [viewControllers addObject:vc];
    }
    //创建滚动视图
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.btnSelectedColor = RedColor;
    _slideSwitch.btnNormalColor = GrayColor;
    //设置要显示的视图集合
    _slideSwitch.viewControllers = viewControllers;
    [self.view addSubview:_slideSwitch];
}

#pragma mark -
#pragma mark SlideSwitchDelegate

-(void)slideSwitchDidselectTab:(NSUInteger)index{
    //可以通过viewWillAppear方法加载数据
    UIViewController * vc = _slideSwitch.viewControllers[index];
    [vc viewWillAppear:YES];
}

-(void)slideSwitchPanLeftEdge:(UIPanGestureRecognizer *)panParam{
    NSLog(@"滑动到左边缘，可以处理滑动返回等一些问题");
}

-(void)slideSwitchPanRightEdge:(UIPanGestureRecognizer *)panParam{
    
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
