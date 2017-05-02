//
//  XLSegmentSlideSwitch.h
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLSlideSwitchDelegate.h"

@interface XLSegmentedSlideSwitch : UIView
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
 * Segmented高亮颜色
 */
@property (nonatomic ,strong) UIColor *tintColor;



/**
 代理方法
 */
@property (nonatomic ,weak) id <XLSlideSwitchDelegate>delegate;

/**
 * 在NavigationBar上显示标题
 */
-(void)showTitlesInNavBarOfVC:(UIViewController*)viewControler;

@end
