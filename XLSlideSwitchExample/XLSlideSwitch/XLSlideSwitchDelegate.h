//
//  XLSlideSwitchDelegate.h
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/5/2.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLSlideSwitchDelegate <NSObject>

@optional
/**
 * 切换位置后的代理方法
 */
- (void)slideSwitchDidselectAtIndex:(NSInteger)index;

@end
