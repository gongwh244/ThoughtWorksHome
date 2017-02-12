//
//  CommentGroundView.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/12.
//  Copyright © 2017年 gong. All rights reserved.
//

#import "CommentGroundView.h"
#import "CommentCell.h"
@interface CommentGroundView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *comTable;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation CommentGroundView

- (UITableView *)comTable{
    if (!_comTable) {
        _comTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_width - 60 - 30, 0)];
        _comTable.backgroundColor = UIColorFromRGB(0xf3f3f5);
        _comTable.scrollEnabled = NO;
        _comTable.delegate = self;
        _comTable.dataSource = self;
        _comTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _comTable;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xf3f3f5);
    }
    return self;
}

- (void)refreshByArr:(NSArray *)arr{
    
    
    [self addSubview:self.comTable];
    self.dataArr = arr;
    self.comTable.frame = self.bounds;
    [self.comTable reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [CommentCell cellWithTableView:tableView];
    return [cell heightWithModel:self.dataArr[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [CommentCell cellWithTableView:tableView];
    [cell refreshCellWithModel:self.dataArr[indexPath.row]];
    return cell;
}

@end
