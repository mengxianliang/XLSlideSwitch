//
//  XLSegmentSlideSwitch.m
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLSegmentedSlideSwitch.h"
#import "XLSlideSegment.h"

//顶部ScrollView高度
static const CGFloat SegmentHeight = 40.0f;

@interface XLSegmentedSlideSwitch ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    
    UISegmentedControl *_segment;
    
    UIPageViewController *_pageVC;
    
    BOOL _showTitlesInNavBar;
}
@end

@implementation XLSegmentedSlideSwitch

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    //添加分段选择器
    _segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, SegmentHeight - 10)];
    [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_segment];
    
    //添加分页滚动视图控制器
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    _pageVC.view.frame = CGRectMake(0, SegmentHeight, self.bounds.size.width, self.bounds.size.height - SegmentHeight);
    [self addSubview:_pageVC.view];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (_showTitlesInNavBar) {
        _pageVC.view.frame = self.bounds;
    }
    [self performSwitchDelegateMethod];
}

#pragma mark -
#pragma mark Setter&Getter

-(void)setViewControllers:(NSArray *)viewControllers{
    _viewControllers = viewControllers;
    [_pageVC setViewControllers:@[_viewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(void)setTitles:(NSArray *)titles{
    
    _titles = titles;
    for (NSString *title in _titles) {
        [_segment insertSegmentWithTitle:title atIndex:_segment.numberOfSegments animated:false];
    }
    _segment.selectedSegmentIndex = 0;
}

-(void)setTintColor:(UIColor *)tintColor{
    _segment.tintColor = tintColor;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    _segment.selectedSegmentIndex = _selectedIndex;
}

#pragma mark -
#pragma mark SlideSegmentDelegate

-(void)segmentValueChanged:(UISegmentedControl *)segment{
    NSInteger index = segment.selectedSegmentIndex;
    __weak __typeof(self)weekSelf = self;
    [_pageVC setViewControllers:@[_viewControllers[index]] direction:index<_selectedIndex animated:YES completion:^(BOOL finished) {
        _selectedIndex = index;
        [weekSelf performSwitchDelegateMethod];
    }];
    
}

#pragma mark -
#pragma mark UIPageViewControllerDelegate&DataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController *vc;
    if (_selectedIndex + 1 < _viewControllers.count) {
        vc = _viewControllers[_selectedIndex + 1];
        vc.view.bounds = pageViewController.view.bounds;
    }
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController *vc;
    if (_selectedIndex - 1 >= 0) {
        vc = _viewControllers[_selectedIndex - 1];
        vc.view.bounds = pageViewController.view.bounds;
    }
    return vc;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    _selectedIndex = [_viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
    _segment.selectedSegmentIndex = _selectedIndex;
    [self performSwitchDelegateMethod];
}

- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationPortrait;
}

#pragma mark -
#pragma mark 其他方法
-(void)showTitlesInNavBarOfVC:(UIViewController*)viewControler{
    _showTitlesInNavBar = true;
    viewControler.navigationItem.titleView = _segment;
    _segment.backgroundColor = [UIColor clearColor];
}

//执行切换代理方法
-(void)performSwitchDelegateMethod{
    if ([_delegate respondsToSelector:@selector(slideSwitchDidselectAtIndex:)]) {
        [_delegate slideSwitchDidselectAtIndex:_selectedIndex];
    }
}


@end
