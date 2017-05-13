//
//  XLSlideSegment.h
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLSlideSegmentDelegate <NSObject>

-(void)slideSegmentDidSelectedAtIndex:(NSInteger)index;

@end

@interface XLSlideSegment : UIView

@property (nonatomic ,assign) NSInteger selectedIndex;

@property (nonatomic ,strong) NSArray *titles;

@property (nonatomic ,strong) UIColor *itemNormalColor;

@property (nonatomic ,strong) UIColor *itemSelectedColor;

@property (nonatomic ,assign) BOOL showTitlesInNavBar;

@property (nonatomic ,assign) BOOL hideShadow;

@property (nonatomic ,weak) id<XLSlideSegmentDelegate>delegate;

@end
