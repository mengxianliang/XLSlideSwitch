//
//  XLSegmentSlideSwitch.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLSegmentedSlideSwitch.h"
//顶部ScrollView高度
static const CGFloat TopViewHeight = 40.0f;

@interface XLSegmentedSlideSwitch ()<UIScrollViewDelegate>
{
    //界面滑动的ScrollView
    UIScrollView *_mainScrollView;
    //按钮与下半部分的分割线
    UIView *_lineView;
    //存放view
    NSMutableArray *_views;
    
    //显示在navbar上
    BOOL _showInNavBar;
}
@end

@implementation XLSegmentedSlideSwitch

#pragma mark -
#pragma mark 初始化方法

-(instancetype)init
{
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self buildUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    _views = [NSMutableArray new];
    _selectedIndex = 0;
    
    //防止navigationbar对ScrollView的布局产生影响
    [self addSubview:[UIView new]];
    
    //创建展示视图控制器的ScrollView
    _mainScrollView = [UIScrollView new];
    _mainScrollView.delegate = self;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.userInteractionEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [_mainScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_mainScrollView];
    
    //创建底部分割条
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    [self addSubview:_lineView];
}

-(void)initSegmentedControl:(NSArray<NSString *> *)items
{
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmentedControlMethod:) forControlEvents:UIControlEventValueChanged];
    if (_tintColor) {
        _segmentedControl.tintColor = _tintColor;
    }
    [self addSubview:_segmentedControl];
}

#pragma mark -
#pragma mark LayoutSubViews

//更新View
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //上半部分
    if (!_showInNavBar) {
        CGFloat segmentMargin = 5.0f;
        _segmentedControl.frame = CGRectMake(segmentMargin, segmentMargin, self.bounds.size.width - 2*segmentMargin,TopViewHeight - 2*segmentMargin);
    }
    _segmentedControl.tintColor = _tintColor;
    
    
    //分割线
    _lineView.frame = CGRectMake(0, TopViewHeight, self.bounds.size.width, 0.5);
    if (_showInNavBar) {
        _lineView.hidden = true;
    }

    
    //下半部分
    _mainScrollView.frame = CGRectMake(0, TopViewHeight, self.bounds.size.width, self.bounds.size.height - TopViewHeight);
    if (_showInNavBar) {
        _mainScrollView.frame = self.bounds;
    }
    _mainScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewControllers count], 0);
    //分配子view的frame
    for (NSInteger i = 0; i<_views.count; i++) {
        UIView *view = _views[i];
        view.frame = CGRectMake(i*_mainScrollView.bounds.size.width, 0, _mainScrollView.bounds.size.width, _mainScrollView.bounds.size.height);
    }
}


#pragma mark -
#pragma mark Setters

//设置要显示的视图控制器
-(void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    NSMutableArray *titles = [NSMutableArray new];
    //添加子view
    for (NSInteger i = 0; i<viewControllers.count; i++) {
        UIViewController *vc = viewControllers[i];
        [_mainScrollView addSubview:vc.view];
        vc.view.tag = i;
        [_views addObject:vc.view];
        [titles addObject:vc.title];
    }
    
    [self initSegmentedControl:titles];
}

//设置当前选中位置
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    //更新frame
    [self updateUIWithSelectedIndex:selectedIndex byButton:true];
}

#pragma mark -
#pragma mark 视图逻辑方法
/**
 更新UI方法
 */
-(void)updateUIWithSelectedIndex:(NSInteger)index byButton:(BOOL)byButton
{
    _selectedIndex = index;
    
    _segmentedControl.selectedSegmentIndex = _selectedIndex;
    
    if (byButton) {
        //更新主ScrollView范围
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mainScrollView setContentOffset:CGPointMake(index * self.bounds.size.width, 0) animated:YES];
        });
    }
    
    if ([_delegate respondsToSelector:@selector(slideSwitchDidselectTab:)]) {
        [_delegate slideSwitchDidselectTab:index];
    }
}

//按钮点击方法
- (void)segmentedControlMethod:(UISegmentedControl *)control
{
    [self updateUIWithSelectedIndex:control.selectedSegmentIndex byButton:true];
}

#pragma mark -
#pragma mark ScrollView Delegate

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        NSInteger index = (NSInteger)scrollView.contentOffset.x/self.bounds.size.width;
        [self updateUIWithSelectedIndex:index byButton:false];
    }
}

//滚动到左右边缘的范围
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(_mainScrollView.contentOffset.x <= 0) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(slideSwitchPanLeftEdge:)]) {
            [_delegate slideSwitchPanLeftEdge:panParam];
        }
    } else if(_mainScrollView.contentOffset.x >= _mainScrollView.contentSize.width - _mainScrollView.bounds.size.width) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(slideSwitchPanRightEdge:)]) {
            [_delegate slideSwitchPanRightEdge:panParam];
        }
    }
}

#pragma mark -
#pragma mark 功能方法
-(void)showsInNavBarOf:(UIViewController *)vc
{
    _showInNavBar = true;
    CGFloat segmentMargin = 5.0f;
    _segmentedControl.frame = CGRectMake(segmentMargin, segmentMargin, self.bounds.size.width - 2*segmentMargin,TopViewHeight - 2*segmentMargin);
    vc.navigationItem.titleView = _segmentedControl;
}

@end
