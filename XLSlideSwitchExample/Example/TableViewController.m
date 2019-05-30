//
//  TableViewController.m
//  XLSlideSwitchExample
//
//  Created by MengXianLiang on 2017/5/18.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "TableViewController.h"
#import "CollectionViewController.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildTable];
}

- (void)buildTable {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    cell.detailTextLabel.text = @"点击跳转新界面";
    cell.detailTextLabel.textColor = self.navigationController.navigationBar.tintColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
