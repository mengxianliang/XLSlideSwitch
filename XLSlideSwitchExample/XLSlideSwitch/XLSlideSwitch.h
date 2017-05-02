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
 代理方法
 */
@property (nonatomic ,weak) id <XLSlideSwitchDelegate>delegate;

/**
 * 在NavigationBar上显示标题
 */
-(void)showTitlesInNavBarOfVC:(UIViewController*)viewControler;

@end
