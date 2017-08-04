//
//  XLSlideSegment.m
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLSlideSegmented.h"
#import "XLSlideSegmentedItem.h"

//item间隔
static const CGFloat ItemMargin = 10.0f;
//button标题选中大小
static const CGFloat ItemFontSize = 17.0f;
//最大放大倍数
static const CGFloat ItemMaxScale = 1.1;

@interface XLSlideSegmented ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    
    UIView *_bottomLine;
    
    UIView *_shadow;
}
@end

@implementation XLSlideSegmented

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    
    self.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:246.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    [self addSubview:[UIView new]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = ItemMargin;
    layout.sectionInset = UIEdgeInsetsMake(0, ItemMargin, 0, ItemMargin);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[XLSlideSegmentedItem class] forCellWithReuseIdentifier:@"XLSlideSegmentedItem"];
    _collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:_collectionView];
    
    _shadow = [[UIView alloc] init];
    [_collectionView addSubview:_shadow];
    
    _bottomLine = [UIView new];
    _bottomLine.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    _bottomLine.frame = CGRectMake(0, _collectionView.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    [self addSubview:_bottomLine];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    //如果标题过少 自动居中
    [_collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        if (_collectionView.contentSize.width < _collectionView.bounds.size.width) {
            CGFloat insetX = (_collectionView.bounds.size.width - _collectionView.contentSize.width)/2.0f;
            _collectionView.contentInset = UIEdgeInsetsMake(0, insetX, 0, insetX);
        }
    }];
    //设置阴影
    _shadow.backgroundColor = _itemSelectedColor;
    self.selectedIndex = _selectedIndex;
    _shadow.hidden = _hideShadow;
}

#pragma mark -
#pragma mark Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    _selectedIndex = selectedIndex;
    
    //更新阴影位置（延迟是为了避免cell不在屏幕上显示时，造成的获取frame失败问题）
    CGFloat rectX = [self shadowRectOfIndex:_selectedIndex].origin.x;
    if (rectX <= 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            _shadow.frame = [self shadowRectOfIndex:_selectedIndex];
        });
    }else{
        _shadow.frame = [self shadowRectOfIndex:_selectedIndex];
    }
    
    //居中滚动标题
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    
    //更新字体大小
    [_collectionView reloadData];
    
    //执行代理方法
    if ([_delegate respondsToSelector:@selector(slideSegmentDidSelectedAtIndex:)]) {
        [_delegate slideSegmentDidSelectedAtIndex:_selectedIndex];
    }
}

- (void)setShowTitlesInNavBar:(BOOL)showTitlesInNavBar {
    _showTitlesInNavBar = showTitlesInNavBar;
    self.backgroundColor = [UIColor clearColor];
    _bottomLine.hidden = true;
    _shadow.hidden = true;
}

//更新阴影位置
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    //如果手动点击则不执行以下动画
    if (_ignoreAnimation) {return;}
    //更新阴影位置
    [self updateShadowPosition:progress];
    //更新标题颜色、大小
    [self updateItem:progress];
}

#pragma mark -
#pragma mark 执行阴影过渡动画
//更新阴影位置
- (void)updateShadowPosition:(CGFloat)progress {
    
    //progress > 1 向左滑动表格反之向右滑动表格
    NSInteger nextIndex = progress > 1 ? _selectedIndex + 1 : _selectedIndex - 1;
    if (nextIndex < 0 || nextIndex == _titles.count) {return;}
    //获取当前阴影位置
    CGRect currentRect = [self shadowRectOfIndex:_selectedIndex];
    CGRect nextRect = [self shadowRectOfIndex:nextIndex];
    //如果在此时cell不在屏幕上 则不显示动画
    if (CGRectGetMinX(currentRect) <= 0 || CGRectGetMinX(nextRect) <= 0) {return;}
    
    progress = progress > 1 ? progress - 1 : 1 - progress;
    
    //更新宽度
    CGFloat width = currentRect.size.width + progress*(nextRect.size.width - currentRect.size.width);
    CGRect bounds = _shadow.bounds;
    bounds.size.width = width;
    _shadow.bounds = bounds;
    
    //更新位置
    CGFloat distance = CGRectGetMidX(nextRect) - CGRectGetMidX(currentRect);
    _shadow.center = CGPointMake(CGRectGetMidX(currentRect) + progress* distance, _shadow.center.y);
}

//更新标题颜色
- (void)updateItem:(CGFloat)progress {
    
    NSInteger nextIndex = progress > 1 ? _selectedIndex + 1 : _selectedIndex - 1;
    if (nextIndex < 0 || nextIndex == _titles.count) {return;}
    
    XLSlideSegmentedItem *currentItem = (XLSlideSegmentedItem *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    XLSlideSegmentedItem *nextItem = (XLSlideSegmentedItem *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:nextIndex inSection:0]];
    progress = progress > 1 ? progress - 1 : 1 - progress;
    
    //更新颜色
    currentItem.textLabel.textColor = [self transformFromColor:_itemSelectedColor toColor:_itemNormalColor progress:progress];
    nextItem.textLabel.textColor = [self transformFromColor:_itemNormalColor toColor:_itemSelectedColor progress:progress];
    
    //更新放大
    CGFloat currentItemScale = ItemMaxScale - (ItemMaxScale - 1) * progress;
    CGFloat nextItemScale = 1 + (ItemMaxScale - 1) * progress;
    currentItem.transform = CGAffineTransformMakeScale(currentItemScale, currentItemScale);
    nextItem.transform = CGAffineTransformMakeScale(nextItemScale, nextItemScale);
}

#pragma mark -
#pragma mark CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self itemWidthOfIndexPath:indexPath], _collectionView.bounds.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLSlideSegmentedItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLSlideSegmentedItem" forIndexPath:indexPath];
    item.textLabel.text = _titles[indexPath.row];
    item.textLabel.font = [UIFont boldSystemFontOfSize:ItemFontSize];
    
    CGFloat scale = indexPath.row == _selectedIndex ? ItemMaxScale : 1;
    item.transform = CGAffineTransformMakeScale(scale, scale);

    item.textLabel.textColor = indexPath.row == _selectedIndex ? _itemSelectedColor : _itemNormalColor;
    return item;
}

//获取文字宽度
- (CGFloat)itemWidthOfIndexPath:(NSIndexPath*)indexPath {
    NSString *title = _titles[indexPath.row];
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:ItemFontSize], NSParagraphStyleAttributeName : style };
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)
                                          options:opts
                                       attributes:attributes
                                          context:nil].size;
    return textSize.width;
}


- (CGRect)shadowRectOfIndex:(NSInteger)index {
    return CGRectMake([_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]].frame.origin.x, self.bounds.size.height - 2, [self itemWidthOfIndexPath:[NSIndexPath indexPathForRow:index inSection:0]], 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    _ignoreAnimation = true;
}

#pragma mark -
#pragma mark 功能性方法
- (UIColor *)transformFromColor:(UIColor*)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    
    if (!fromColor || !toColor) {
        NSLog(@"Warning !!! color is nil");
        return [UIColor blackColor];
    }
    
    progress = progress >= 1 ? 1 : progress;
    
    progress = progress <= 0 ? 0 : progress;
    
    const CGFloat * fromeComponents = CGColorGetComponents(fromColor.CGColor);

    const CGFloat * toComponents = CGColorGetComponents(toColor.CGColor);
    
    size_t  fromColorNumber = CGColorGetNumberOfComponents(fromColor.CGColor);
    size_t  toColorNumber = CGColorGetNumberOfComponents(toColor.CGColor);
    
    if (fromColorNumber == 2) {
        CGFloat white = fromeComponents[0];
        fromColor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        fromeComponents = CGColorGetComponents(fromColor.CGColor);
    }
    
    if (toColorNumber == 2) {
        CGFloat white = toComponents[0];
        toColor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        toComponents = CGColorGetComponents(toColor.CGColor);
    }
    
    CGFloat red = fromeComponents[0]*(1 - progress) + toComponents[0]*progress;
    CGFloat green = fromeComponents[1]*(1 - progress) + toComponents[1]*progress;
    CGFloat blue = fromeComponents[2]*(1 - progress) + toComponents[2]*progress;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}


@end
