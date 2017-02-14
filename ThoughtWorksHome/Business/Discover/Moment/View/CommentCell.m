//
//  CommentCell.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/12.
//  Copyright © 2017年 gong. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()

@property (nonatomic,strong) UILabel *comLabel;

@end

@implementation CommentCell

- (UILabel *)comLabel{
    if (!_comLabel) {
        _comLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, Screen_width - 90 -5, 0)];
        _comLabel.textAlignment = NSTextAlignmentLeft;
        _comLabel.numberOfLines = 0;
        _comLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _comLabel;
}

+ (CommentCell *)cellWithTableView:(UITableView *)tableView{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[CommentCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xf3f3f5);
        [self addSubview:self.comLabel];
    }
    return self;
}

- (CGFloat)heightWithModel:(CommentModel *)model{
    
    NSString *content = [NSString stringWithFormat:@"%@:%@ %@ %@",model.sender.nick,model.content,model.content,model.content];
    NSAttributedString *name = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(Screen_width - 90, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    CGSize nameSize = nameRect.size;
    return nameSize.height + 6;
}

- (void)refreshCellWithModel:(CommentModel *)model{
    
    NSString *nick = [NSString stringWithFormat:@"%@:",model.sender.nick];
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@",model.content,model.content,model.content];
    NSString *content = [NSString stringWithFormat:@"%@%@",nick,text];
    
    NSMutableAttributedString *beforeStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [beforeStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x616887) range:[content rangeOfString:nick]];
    [beforeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:[content rangeOfString:nick]];
    [beforeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[content rangeOfString:text]];
    self.comLabel.attributedText = beforeStr;
    
    CGRect nameRect = [beforeStr boundingRectWithSize:CGSizeMake(Screen_width - 90, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    self.comLabel.frame = CGRectMake(CGRectGetMinX(self.comLabel.frame), CGRectGetMinY(self.comLabel.frame), CGRectGetWidth(self.comLabel.frame), nameRect.size.height);
}


@end
