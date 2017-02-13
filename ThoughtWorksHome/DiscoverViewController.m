//
//  DiscoverViewController.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import "DiscoverViewController.h"
#import "MomentsViewController.h"

@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSArray *arr;

@end

@implementation DiscoverViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.table];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"朋友圈";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MomentsViewController *vc = [[MomentsViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
