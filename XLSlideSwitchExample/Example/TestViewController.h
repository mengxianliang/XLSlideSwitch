//
//  TestViewController.h
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestViewControllerDelegate <NSObject>

-(void)testTableViewDidClickAt:(NSIndexPath*)indexPath;

@end

@interface TestViewController : UIViewController

@property (nonatomic,weak) id<TestViewControllerDelegate>delegate;

@end
