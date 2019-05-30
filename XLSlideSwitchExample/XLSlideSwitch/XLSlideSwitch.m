//
//  XLSlideSwitch.m
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLSlideSwitch.h"

//顶部ScrollView高度
static const CGFloat SegmentHeight = 40.0f;

@interface XLSlideSwitch ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,XLSlideSegmentDelegate,UIScrollViewDelegate> {
    BOOL _showHeaderViewInNaviagtionBar;
}

@property (nonatomic, strong) UIPageViewController *pageVC;

@end

@implementation XLSlideSwitch

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self addSubview:[UIView new]];
    
    //添加标题栏
    _headerView = [[XLSlideSwitchHeaderView alloc] init];
    _headerView.delegate = self;
    [self addSubview:_headerView];
    
    //添加分页滚动视图控制器
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    [self addSubview:_pageVC.view];
    
    //设置ScrollView代理
    for (UIScrollView *scrollView in _pageVC.view.subviews) {
        if ([scrollView isKindOfClass:[UIScrollView class]]) {
            scrollView.delegate = self;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headerView.frame = CGRectMake(0, 0, self.bounds.size.width, SegmentHeight);
    _pageVC.view.frame = CGRectMake(0, SegmentHeight, self.bounds.size.width, self.bounds.size.height - SegmentHeight);
}

- (void)showInViewController:(UIViewController *)viewController {
    [viewController addChildViewController:_pageVC];
    [viewController.view addSubview:self];
}

- (void)showInNavigationController:(UINavigationController *)navigationController {
    [navigationController.topViewController.view addSubview:self];
    [navigationController.topViewController addChildViewController:_pageVC];
    navigationController.topViewController.navigationItem.titleView = _headerView;
    _pageVC.view.frame = self.bounds;
    _headerView.showTitlesInNavBar = true;
    _showHeaderViewInNaviagtionBar = true;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self switchToIndex:_selectedIndex];
}

#pragma mark -
#pragma mark Setter&Getter

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    _headerView.titles = titles;
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    _headerView.itemSelectedColor = itemSelectedColor;
}

- (void)setItemNormalColor:(UIColor *)itemNormalColor {
    _headerView.itemNormalColor = itemNormalColor;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex >= _titles.count) {return;}
    _selectedIndex = selectedIndex;
    [self switchToIndex:_selectedIndex];
    _headerView.selectedIndex = _selectedIndex;
    _headerView.ignoreAnimation = true;
}

#pragma mark -
#pragma mark SlideSegmentDelegate
- (void)slideSegmentDidSelectedAtIndex:(NSInteger)index {
    if (index == _selectedIndex) {return;}
    [self switchToIndex:index];
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
    _headerView.selectedIndex = _selectedIndex;
    [self performSwitchDelegateMethod];
}

- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationPortrait;
}

#pragma mark -
#pragma mark ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == scrollView.bounds.size.width) {return;}
    CGFloat progress = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _headerView.progress = progress;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _headerView.ignoreAnimation = false;
}

#pragma mark -
#pragma mark 其他方法
- (void)switchToIndex:(NSInteger)index {
    __weak __typeof(self)weekSelf = self;
    [_pageVC setViewControllers:@[_viewControllers[index]] direction:index<_selectedIndex animated:YES completion:^(BOOL finished) {
        _selectedIndex = index;
        [weekSelf performSwitchDelegateMethod];
    }];
}

//执行切换代理方法
- (void)performSwitchDelegateMethod {
    if ([_delegate respondsToSelector:@selector(slideSwitchDidselectAtIndex:)]) {
        [_delegate slideSwitchDidselectAtIndex:_selectedIndex];
    }
}

@end
