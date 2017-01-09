//
//  XLSlideSwitchDelegate.h
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLSlideSwitchDelegate <NSObject>
@optional
/**
 切换位置
 */
- (void)slideSwitchDidselectTab:(NSUInteger)index;
/*
 滑动到左边界时调用
 */
- (void)slideSwitchPanLeftEdge:(UIPanGestureRecognizer *)panParam;

/**
 滑动到右边界时调用
 */
- (void)slideSwitchPanRightEdge:(UIPanGestureRecognizer *)panParam;

@end
