//
//  TweetCell.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//


#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface TweetCell ()

@property (nonatomic,strong) TweetModel *tweet;

@property (nonatomic,strong) UIImageView *avatarImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *imageGround;

@end

@implementation TweetCell

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
        _avatarImage.backgroundColor = [UIColor yellowColor];
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.borderColor = [UIColor grayColor].CGColor;
        _avatarImage.layer.borderWidth = 0.3;
    }
    return _avatarImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, Screen_width - 60 - 30, 20)];
        _nameLabel.text = @"aldsjfal";
        _nameLabel.backgroundColor = [UIColor blueColor];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, Screen_width - 60 - 30, 0)];
        _contentLabel.backgroundColor = [UIColor grayColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)imageGround{
    if (!_imageGround) {
        _imageGround = [[UIView alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.contentLabel.frame), Screen_width - 60 - 30, 0)];//100
        _imageGround.backgroundColor = [UIColor redColor];
    }
    return _imageGround;
}

#pragma mark -----------------------------------

+ (TweetCell *)cellWithTableView:(UITableView *)tableView{
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[TweetCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.avatarImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.imageGround];
        self.cellHeight = 180;
    }
    return self;
}

- (void)refreshCellWithModel:(TweetModel *)model{
    
    self.tweet = model;
    
    [self.avatarImage setImageWithURL:[NSURL URLWithString:model.sender.avatar] placeholderImage:nil];
    self.nameLabel.text = model.sender.nick;
    
    self.contentLabel.text = model.content;
    if (model.content) {
        CGFloat contentHeight = [self getLabelHeightWithFont:15 labelWidth:CGRectGetWidth(self.contentLabel.frame) string:self.contentLabel.text];
        self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.contentLabel.frame), CGRectGetMaxY(self.nameLabel.frame), CGRectGetWidth(self.contentLabel.frame), contentHeight);
    }
    
    if (model.images) {
        CGFloat groundHeight = [self getImageGroundHeightWithArr:model.images];
        self.imageGround.frame = CGRectMake(CGRectGetMinX(self.imageGround.frame), CGRectGetMaxY(self.contentLabel.frame), CGRectGetWidth(self.imageGround.frame), groundHeight);
    }
    
    self.cellHeight = CGRectGetMaxY(self.imageGround.frame);
    
    [self layoutImageGround];
    
    
    if (self.cellHeight < 60) {
        self.cellHeight = 60;
    }
    self.cellHeight += 20;
}



- (void)layoutImageGround{
    
    CGFloat groundWidth = Screen_width - 90;
    CGFloat spaceWidth = (groundWidth - 70 * 3)/2;
    CGFloat imageWidth = 70;
    
    for (int i = 0; i < self.tweet.images.count; i++) {
        
        CGFloat x = 0;
        CGFloat y = 0;
        x = (i % 3) * (imageWidth + spaceWidth);
        y = (i / 3) * (imageWidth + spaceWidth);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWidth, imageWidth)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.tweet.images[i]] placeholderImage:[UIImage imageNamed:@"ThoughtWorks.png"] completed:nil];
        [self.imageGround addSubview:imageView];
    }
}



- (CGFloat)getLabelHeightWithFont:(CGFloat)font labelWidth:(CGFloat)width string:(NSString *)string{
    
    NSAttributedString *name = [[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize nameSize = nameRect.size;
    return nameSize.height;
}

- (CGFloat)getImageGroundHeightWithArr:(NSArray *)arr{
    
    CGFloat groundWidth = Screen_width - 90;
    CGFloat spaceWidth = (groundWidth - 70 * 3)/2;
    CGFloat imageWidth = 70;
    
    
    if (arr.count == 0) {
        return 0;
    }else{
        NSInteger line = (arr.count -1)/3;
        if (line == 0) {
            return imageWidth;
        }
        if (line == 1) {
            return imageWidth * 2 + spaceWidth;
        }
        if (line == 2) {
            return groundWidth;
        }
        return 0;
    }
}

#pragma mark -----------------------------------
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
