//
//  XLSlideView.h
//  XLSlideViewDemo
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLSlideSwitchDelegate.h"

@interface XLSlideSwitch : UIView
/**
 代理
 */
@property (weak,nonatomic) id <XLSlideSwitchDelegate>delegate;
/**
 顶部scroll
 */
@property (strong,nonatomic,readonly)  UIScrollView *topScrollView;
/**
 需要显示的viewController集合
 */
@property (strong,nonatomic) NSMutableArray *viewControllers;
/**
 是否隐藏选中效果
 */
@property (assign,nonatomic) BOOL hideShadow;
/**
 当前选中位置
 */
@property (assign,nonatomic) NSInteger selectedIndex;
/**
 按钮正常时的颜色
 */
@property (strong,nonatomic) UIColor *btnNormalColor;
/**
 按钮选中时的颜色
 */
@property (strong,nonatomic) UIColor *btnSelectedColor;
/**
 是否需要自动分配按钮宽度
 */
@property (assign,nonatomic) BOOL adjustBtnSize2Screen;

/**
 显示在某个VC的navbar上
 */
-(void)showsInNavBarOf:(UIViewController *)vc;

@end
