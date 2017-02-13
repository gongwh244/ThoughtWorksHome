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
#import "TweetModel.h"
#import "UIImageView+AFNetworking.h"

@interface MomentsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UserModel *infoModel;
@property (nonatomic,strong) NSArray *tweetArr;

@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UIImageView *profileImage;
@property (nonatomic,strong) UIImageView *avatarImage;

@property (nonatomic,strong) UIActivityIndicatorView *activity;

@property (nonatomic,strong) UIView *head;
@property (nonatomic,strong) UITableView *table;

@property (nonatomic,assign) BOOL start;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,assign) NSInteger num;

@end

@implementation MomentsViewController

#pragma mark - Property Get Method

- (UILabel *)nickLabel{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_width - 64 + 20 - 40, Screen_width - 10 - 60 - 20 + 10, 15)];
        _nickLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
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
        _head.backgroundColor = [UIColor whiteColor];
        [_head addSubview:self.profileImage];
        [_head addSubview:self.avatarImage];
        [_head addSubview:self.nickLabel];
        
        [_head addSubview:self.activity];
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
        _table.separatorInset = UIEdgeInsetsZero;
        _table.layoutMargins = UIEdgeInsetsZero;
    }
    return _table;
}

- (UIActivityIndicatorView *)activity{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.frame = CGRectMake(0, -44, 44, 44);
        _activity.hidesWhenStopped = NO;
    }
    return _activity;
}

#pragma mark Normal Method

- (void)makeTableView{
    
    [self.view addSubview:self.table];
    UIView *view = [[UIView alloc] init];
    self.table.tableFooterView = view;
    __weak typeof(self) weakSelf = self;
    [self.table addPullToRefreshWithActionHandler:^{
        weakSelf.num ++;
        [weakSelf getListWithPage:weakSelf.num];
    } position:SVPullToRefreshPositionBottom];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"朋友圈";
    _num = 1;
    [self makeTableView];
//    [self refreshData];
    
    [self refreshUser];
    [self getListWithPage:1];
}

- (void)refreshUser{
    MomentsViewModel *viewModel = [[MomentsViewModel alloc] init];
    [viewModel setBlocksWithSucBlock:^(id returnData) {
        
        _isLoading = NO;
        self.infoModel = (UserModel *)returnData;
        [self.profileImage setImageWithURL:[NSURL URLWithString:self.infoModel.profileImage] placeholderImage:[UIImage imageNamed:@"ThoughtWorks.png"]];
        [self.avatarImage setImageWithURL:[NSURL URLWithString:self.infoModel.avatar]];
        self.nickLabel.text = self.infoModel.nick;
        
    } faiBlock:^(id returnData) {
        TWLog(@"error = %@",returnData);
    }];
    _isLoading = YES;
    [viewModel getUserInfo];
}

//- (void)refreshData{
//    
//    
//    MomentsViewModel *viewModel = [[MomentsViewModel alloc] init];
//    [viewModel setBlocksWithSucBlock:^(id returnData) {
//        
//        _isLoading = NO;
//        self.infoModel = (UserModel *)returnData;
//        [self refreshHead];
//        
//    } faiBlock:^(id returnData) {
//        TWLog(@"error = %@",returnData);
//    }];
//    _isLoading = YES;
//    [viewModel getUserInfo];
//}

- (void)getListWithPage:(NSInteger)page{
    
    MomentsViewModel *vm = [[MomentsViewModel alloc] init];
    [vm setBlocksWithSucBlock:^(id returnData) {
        _isLoading = NO;
        self.tweetArr = (NSArray *)returnData;
        [self.table reloadData];
        _start = NO;
        [self.activity stopAnimating];
        [self.table.pullToRefreshView stopAnimating];
        [UIView animateWithDuration:0.3 animations:^{
            self.activity.frame = CGRectMake(0, -44, 44, 44);
        } completion:^(BOOL finished) {
            
        }];
        
    } faiBlock:^(id returnData) {
        TWLog(@"error = %@",returnData);
    }];
    _isLoading = YES;
    [vm getTweetListWithPage:page];
}

//- (void)refreshHead{
//    
//    [self.profileImage setImageWithURL:[NSURL URLWithString:self.infoModel.profileImage] placeholderImage:[UIImage imageNamed:@"ThoughtWorks.png"]];
//    [self.avatarImage setImageWithURL:[NSURL URLWithString:self.infoModel.avatar]];
//    self.nickLabel.text = self.infoModel.nick;
//    [self getListWithPage:1];
//}


#pragma mark TableView Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweetArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetModel *model = self.tweetArr[indexPath.row];
    TweetCell *cell = [TweetCell cellWithTableView:tableView];
    [cell refreshCellWithModel:model];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetModel *model = self.tweetArr[indexPath.row];
    TweetCell *cell = [TweetCell cellWithTableView:tableView];
    [cell refreshCellWithModel:model];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y < -44-64) {
        [self.activity startAnimating];
        _start = YES;
        if (!_isLoading) {
            [self refreshUser];
            [self getListWithPage:1];;
        }
    }
    if (_start) {
        self.activity.frame = CGRectMake(0, scrollView.contentOffset.y + 64, 44, 44);
    }
}


@end
