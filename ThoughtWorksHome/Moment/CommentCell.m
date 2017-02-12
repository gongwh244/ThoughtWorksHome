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
        _comLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, Screen_width - 90, 0)];
        _comLabel.textAlignment = NSTextAlignmentLeft;
        _comLabel.numberOfLines = 0;
        _comLabel.backgroundColor = [UIColor yellowColor];
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
    
    NSString *content = [NSString stringWithFormat:@"%@:%@ %@ %@",model.sender.nick,model.content,model.content,model.content];
    [self setLabel:self.comLabel font:13 width:Screen_width - 90 string:content];
}

- (CGFloat)setLabel:(UILabel *)label font:(CGFloat)font width:(CGFloat)width string:(NSString *)string{
    
    NSAttributedString *name = [[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    CGSize nameSize = nameRect.size;
    label.attributedText = name;
    label.frame = CGRectMake(CGRectGetMinX(label.frame), CGRectGetMinY(label.frame), CGRectGetWidth(label.frame), nameSize.height);
    return nameSize.height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
