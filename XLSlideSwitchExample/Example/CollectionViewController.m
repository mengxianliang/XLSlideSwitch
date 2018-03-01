//
//  CollectionViewController.m
//  XLSlideSwitchExample
//
//  Created by MengXianLiang on 2017/5/18.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "CollectionViewController.h"
#import "TableViewController.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    UICollectionView *_collectionView;
}
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat margin = 10.0f;
    CGFloat itemWidth = (self.view.bounds.size.width - 4*margin - 1)/3.0f;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:_collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark CollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = self.navigationController.navigationBar.tintColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TableViewController *vc = [[TableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
