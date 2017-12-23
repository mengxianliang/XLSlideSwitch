//
//  SlideSwitchExample1.m
//  XLSlideSwitchExample
//
//  Created by MengXianLiang on 2017/5/2.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "SlideSwitchExample1.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

#import "XLSlideSwitch.h"

@interface SlideSwitchExample1 ()<XLSlideSwitchDelegate> {
    XLSlideSwitch *_slideSwitch;
}
@end

@implementation SlideSwitchExample1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(showNextView)];
    
    //要显示的标题
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    //创建需要展示的ViewController
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i<titles.count; i++) {
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    //创建滚动视图
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) Titles:titles viewControllers:viewControllers];
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = self.navigationController.navigationBar.tintColor;
    _slideSwitch.itemNormalColor = [UIColor darkGrayColor];
    //标题横向间距
    _slideSwitch.customTitleSpacing = 30;
    //更多按钮
    _slideSwitch.moreButton = [self moreButton];
    //显示方法
    [_slideSwitch showInViewController:self];
}

- (UIButton *)moreButton {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"channelAdd"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    return button;
}

#pragma mark -
#pragma mark SlideSwitchDelegate

- (void)slideSwitchDidselectAtIndex:(NSInteger)index {
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}

#pragma mark -
#pragma mark 自定义方法
- (UIViewController *)viewControllerOfIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index%2) {
        case 0:
            vc = [[TableViewController alloc] init];
            break;
        case 1:
            vc = [[CollectionViewController alloc] init];
            break;
        default:
            break;
    }
    return vc;
}

- (void)showNextView {
    _slideSwitch.selectedIndex += 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
