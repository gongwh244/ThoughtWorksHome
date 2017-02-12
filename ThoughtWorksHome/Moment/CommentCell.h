//
//  CommentCell.h
//  ThoughtWorksHome
//
//  Created by gong on 17/2/12.
//  Copyright © 2017年 gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell

+ (CommentCell *)cellWithTableView:(UITableView *)tableView;

- (void)refreshCellWithModel:(CommentModel *)model;

- (CGFloat)heightWithModel:(CommentModel *)model;

@end
