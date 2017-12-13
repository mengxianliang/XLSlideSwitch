//
//  SegmentedSlideSwitchExample2.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SegmentedSlideSwitchExample1.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

#import "XLSegmentedSlideSwitch.h"

@interface SegmentedSlideSwitchExample1 ()<XLSlideSwitchDelegate> {
    XLSegmentedSlideSwitch *_slideSwitch;
}
@end

@implementation SegmentedSlideSwitchExample1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSArray *titles = @[@"今天",@"是个",@"好日子"];
    for (int i = 0 ; i<titles.count; i++) {
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    _slideSwitch = [[XLSegmentedSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) Titles:titles viewControllers:viewControllers];
    _slideSwitch.delegate = self;
    _slideSwitch.tintColor = self.navigationController.navigationBar.tintColor;
    //左右水平缩进
    _slideSwitch.horizontalInset = 50;
    [_slideSwitch showInViewController:self];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
