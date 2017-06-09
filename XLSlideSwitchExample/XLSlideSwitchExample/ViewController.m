//
//  ViewController.m
//  XLSlideSwitchExample
//
//  Created by MengXianLiang on 2017/5/2.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "ViewController.h"

#import "SlideSwitchExample1.h"
#import "SlideSwitchExample2.h"

#import "SegmentedSlideSwitchExample1.h"
#import "SegmentedSlideSwitchExample2.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    self.title = @"XLSlideSwitchExample";
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildTable];
}

- (void)buildTable {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

- (NSArray *)titles {
    return @[@[@"SlideSwitchExample1",@"SlideSwitchExample2"],@[@"SegmentedSlideSwitchExample1",@"SegmentedSlideSwitchExample2"]];
}

- (NSArray *)subTitles {
    return @[@[@"正常显示",@"标题在NavigationBar上显示"],@[@"正常显示",@"标题在NavigationBar上显示"]];
}

- (NSArray*)sectionTitles {
    return @[@"XLSlideSiwtch",@"XLSegmentedSlideSiwtch"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self titles][section];
    return arr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self sectionTitles][section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self sectionTitles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.detailTextLabel.textColor = self.navigationController.navigationBar.tintColor;
    }
    cell.textLabel.text = [self titles][indexPath.section][indexPath.row];
    cell.detailTextLabel.text = [self subTitles][indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self titles][indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                SlideSwitchExample1 *vc = [SlideSwitchExample1 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
            case 1:{
                SlideSwitchExample2 *vc = [SlideSwitchExample2 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:{
                SegmentedSlideSwitchExample1 *vc = [SegmentedSlideSwitchExample1 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
            case 1:{
                SegmentedSlideSwitchExample2 *vc = [SegmentedSlideSwitchExample2 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
            default:
                break;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

