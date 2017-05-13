//
//  XLSlideSegment.m
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLSlideSegment.h"
#import "XLSlideSegmentItem.h"

//item间隔
static const CGFloat ItemMargin = 10.0f;
//button标题正常大小
static const CGFloat ItemNormalFontSize = 17.0f;
//button标题选中大小
static const CGFloat ItemSelectedFontSize = 18.0f;


@interface XLSlideSegment ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    
    UIView *_bottomLine;
    
    UIView *_shadow;
}
@end

@implementation XLSlideSegment

-(instancetype)init{
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    
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
    [_collectionView registerClass:[XLSlideSegmentItem class] forCellWithReuseIdentifier:@"XLSlideSegmentItem"];
    _collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:_collectionView];
    
    _shadow = [[UIView alloc] init];
    [_collectionView addSubview:_shadow];
    
    _bottomLine = [UIView new];
    _bottomLine.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    _bottomLine.frame = CGRectMake(0, _collectionView.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    [self addSubview:_bottomLine];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    //如果标题过少 自动居中
    [_collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        if (_collectionView.contentSize.width < _collectionView.bounds.size.width) {
            CGFloat insetX = (_collectionView.bounds.size.width - _collectionView.contentSize.width)/2.0f;
            _collectionView.contentInset = UIEdgeInsetsMake(0, insetX, 0, insetX);
        }
    }];
    
    //设置设置背景颜色
    _shadow.backgroundColor = _itemSelectedColor;
    _shadow.hidden = _hideShadow;
    //更新UI
    self.selectedIndex = _selectedIndex;
}

#pragma mark -
#pragma mark Setter
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    _selectedIndex = selectedIndex;
    //更新阴影位置
    [UIView animateWithDuration:0.3 animations:^{
        _shadow.frame = CGRectMake([_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]].frame.origin.x, self.bounds.size.height - 2, [self itemWidthOfIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]], 2);
    }];
    //更新字体大小
    [_collectionView reloadData];
    //居中滚动标题
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    //执行代理方法
    if ([_delegate respondsToSelector:@selector(slideSegmentDidSelectedAtIndex:)]) {
        [_delegate slideSegmentDidSelectedAtIndex:_selectedIndex];
    }
}

-(void)setShowTitlesInNavBar:(BOOL)showTitlesInNavBar{
    _showTitlesInNavBar = showTitlesInNavBar;
    self.backgroundColor = [UIColor clearColor];
    _bottomLine.hidden = true;
    _shadow.hidden = true;
}

#pragma mark -
#pragma mark CollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([self itemWidthOfIndexPath:indexPath], _collectionView.bounds.size.height);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLSlideSegmentItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLSlideSegmentItem" forIndexPath:indexPath];
    item.textLabel.text = _titles[indexPath.row];
    item.textLabel.font = indexPath.row == _selectedIndex ? [UIFont boldSystemFontOfSize:ItemSelectedFontSize] : [UIFont systemFontOfSize:ItemNormalFontSize];
    item.textLabel.textColor = indexPath.row == _selectedIndex ? _itemSelectedColor : _itemNormalColor;
    return item;
}

-(CGFloat)itemWidthOfIndexPath:(NSIndexPath*)indexPath{
    NSString *title = _titles[indexPath.row];
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:ItemSelectedFontSize], NSParagraphStyleAttributeName : style };
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)
                                          options:opts
                                       attributes:attributes
                                          context:nil].size;
    return textSize.width;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath.row;
}

@end
