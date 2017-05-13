//
//  XLSlideSwitch.h
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLSlideSwitchDelegate.h"

@interface XLSlideSwitch : UIView

/**
 * 需要显示的视图
 */
@property (nonatomic ,strong) NSArray *viewControllers;
/**
 * 标题
 */
@property (nonatomic ,strong) NSArray *titles;
/**
 * 选中位置
 */
@property (nonatomic ,assign) NSInteger selectedIndex;
/**
 * 按钮正常时的颜色
 */
@property (nonatomic ,strong) UIColor *itemNormalColor;
/**
 * 按钮选中时的颜色
 */
@property (nonatomic ,strong) UIColor *itemSelectedColor;
/**
 * 隐藏阴影
 */
@property (nonatomic ,assign) BOOL hideShadow;
/**
 * 代理方法
 */
@property (nonatomic ,weak) id <XLSlideSwitchDelegate>delegate;
/**
 * 初始化方法
 */
-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray <NSString *>*)titles viewControllers:(NSArray <UIViewController *>*)viewControllers;
/**
 * 标题显示在ViewController中
 */
-(void)showInViewController:(UIViewController *)viewController;
/**
 * 标题显示在NavigationBar中
 */
-(void)showInNavigationController:(UINavigationController *)navigationController;

@end
