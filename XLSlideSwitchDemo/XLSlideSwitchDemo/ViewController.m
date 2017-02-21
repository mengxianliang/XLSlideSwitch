//
//  ViewController.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"

#import "SlideSwitchNormalDemo1.h"
#import "SlideSwitchNormalDemo2.h"

#import "SlideSwitchAdjustScreenDemo1.h"
#import "SlideSwitchAdjustScreenDemo2.h"

#import "SegmentedslideSwitchDemo1.h"
#import "SegmentedSlideSwitchDemo2.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI
{
    self.title = @"XLSlideSwitchDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildTable];
}

-(void)buildTable
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource


-(NSArray *)titles
{
    return @[@[@"SlideSwitchNormalDemo1",@"SlideSwitchNormalDemo2",@"SlideSwitchAdjustScreenDemo1",@"SlideSwitchAdjustScreenDemo2"],@[@"SegmentedSlideSwitchDemo1",@"SegmentedSlideSwitchDemo2"]];
}

-(NSArray *)subTitles
{
    return @[@[@"SlideSwitchNormal",@"SlideSwitchNormalShowInNavigationBar",@"SlideSwitchAdjustScreenWidth",@"SlideSwitchAdjustScreenWidthShowInNavigationBar"],@[@"SegmentedSlideSwitch",@"SegmentedSlideSwitchShowInNavigationBar"]];
}

-(NSArray*)sectionTitles
{
    return @[@"XLSlideSiwtch",@"XLSegmentedSlideSiwtch"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [self titles][section];
    return arr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self sectionTitles][section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self sectionTitles].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = RedColor;
        cell.detailTextLabel.textColor = GrayColor;
    }
    cell.textLabel.text = [self titles][indexPath.section][indexPath.row];
    cell.detailTextLabel.text = [self subTitles][indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self titles][indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                SlideSwitchNormalDemo1 *vc = [SlideSwitchNormalDemo1 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
            case 1:
            {
                SlideSwitchNormalDemo2 *vc = [SlideSwitchNormalDemo2 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;

            case 2:
            {
                SlideSwitchAdjustScreenDemo1 *vc = [SlideSwitchAdjustScreenDemo1 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
            case 3:
            {
                SlideSwitchAdjustScreenDemo2 *vc = [SlideSwitchAdjustScreenDemo2 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                SegmentedSlideSwitchDemo1 *vc = [SegmentedSlideSwitchDemo1 new];
                vc.title = title;
                [self.navigationController pushViewController:vc animated:true];
            }
                break;
            case 1:
            {
                SegmentedSlideSwitchDemo2 *vc = [SegmentedSlideSwitchDemo2 new];
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
