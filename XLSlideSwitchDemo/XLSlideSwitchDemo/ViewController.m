//
//  ViewController.m
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "XLSlideSwitchViewController.h"

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
    return @[@"XLSlideSwitch",@"XLSlideSwitch+AdjustScreen"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self titles].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self titles][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            XLSlideSwitchViewController *vc = [XLSlideSwitchViewController new];
            vc.title = [self titles][indexPath.row];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1:
        {
            XLSlideSwitchViewController *vc = [XLSlideSwitchViewController new];
            vc.title = [self titles][indexPath.row];
            vc.adjustScreen = true;
            [self.navigationController pushViewController:vc animated:true];
        }
            break;    
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
