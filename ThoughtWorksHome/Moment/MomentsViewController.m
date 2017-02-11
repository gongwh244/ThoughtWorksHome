//
//  MomentsViewController.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import "MomentsViewController.h"
#import "MomentsViewModel.h"
#import "UserModel.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface MomentsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UserModel *infoModel;

@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UIImageView *profileImage;
@property (nonatomic,strong) UIImageView *avatarImage;

@property (nonatomic,strong) UIView *head;
@property (nonatomic,strong) UITableView *table;

@end

@implementation MomentsViewController

#pragma mark - Property Get Method

- (UILabel *)nickLabel{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_width - 64 + 20 - 40, Screen_width - 10 - 60 - 20 + 10, 15)];
        _nickLabel.font = [UIFont systemFontOfSize:15];
        _nickLabel.textColor = [UIColor blackColor];
        _nickLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nickLabel;
}

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_width - 60 - 10, Screen_width - 64 + 20 - 60, 60, 60)];
        _avatarImage.backgroundColor = [UIColor whiteColor];
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.borderColor = [UIColor grayColor].CGColor;
        _avatarImage.layer.borderWidth = 0.5;
    }
    return _avatarImage;
}

- (UIImageView *)profileImage{
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, Screen_width, Screen_width)];
    }
    return _profileImage;
}

- (UIView *)head{
    if (!_head) {
        _head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_width + 40 - 64)];
        _head.backgroundColor = [UIColor yellowColor];
        [_head addSubview:self.profileImage];
        [_head addSubview:self.avatarImage];
        [_head addSubview:self.nickLabel];
    }
    return _head;
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds];
        _table.backgroundColor = [UIColor grayColor];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.head;
    }
    return _table;
}

#pragma mark Normal Method

- (void)makeTableView{
    [self.view addSubview:self.table];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"朋友圈";
    [self makeTableView];
    
    MomentsViewModel *viewModel = [[MomentsViewModel alloc] init];
    [viewModel setBlocksWithSucBlock:^(id returnData) {
        
        TWLog(@"%@",returnData);
        self.infoModel = (UserModel *)returnData;
        [self refreshHead];
        
    } faiBlock:^(id returnData) {
        
    }];
    [viewModel getUserInfo];
}

- (void)refreshHead{
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.infoModel.profileImage]];
    [self.avatarImage setImageWithURL:[NSURL URLWithString:self.infoModel.avatar]];
    self.nickLabel.text = self.infoModel.nick;
}


#pragma mark TableView Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [TweetCell cellWithTableView:tableView];
    return cell;
}





























































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
