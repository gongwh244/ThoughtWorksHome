//
//  TweetCell.h
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetModel.h"

@interface TweetCell : UITableViewCell

@property (nonatomic,assign) CGFloat cellHeight;

+ (TweetCell *)cellWithTableView:(UITableView *)tableView;

- (void)refreshCellWithModel:(TweetModel *)model;

@end
