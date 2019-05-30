//
//  XLSlideSwitch.h
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLSlideSwitchHeaderView.h"
#import "XLSlideSwitchDelegate.h"

@interface XLSlideSwitch : UIView

//视图控制器集合
@property (nonatomic, strong) NSArray *viewControllers;
//标题集合
@property (nonatomic, strong) NSArray *titles;
//选中位置
@property (nonatomic, assign) NSInteger selectedIndex;
//标题显示工具
@property (nonatomic, strong) XLSlideSwitchHeaderView *headerView;
/**
 * 代理方法
 */
@property (nonatomic, weak) id <XLSlideSwitchDelegate> delegate;
/**
 * 标题显示在ViewController中
 */
-(void)showInViewController:(UIViewController *)viewController;
/**
 * 标题显示在NavigationBar中
 */
-(void)showInNavigationController:(UINavigationController *)navigationController;

@end
