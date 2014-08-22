//
//  PartnerCommentCell.m
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerCommentCell.h"
#import "UIImageView+WebCache.h"
#import "CommonFuction.h"

@interface PartnerCommentCell ()
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *time;
@property (nonatomic,strong) UILabel *commentContent;
@property (nonatomic,strong) UIImageView *lineImg;
@end

@implementation PartnerCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _userImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_userImg];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectZero];
        _userName.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_userName];
        
        _time = [[UILabel alloc] initWithFrame:CGRectZero];
        _time.font = [UIFont systemFontOfSize:11.0f];
        [self.contentView addSubview:_time];
        
        _commentContent = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentContent.lineBreakMode = NSLineBreakByWordWrapping;
        _commentContent.numberOfLines = 0;
        _commentContent.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_commentContent];
        
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImg.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineImg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPartnerCommentData:(PartnerCommentData *)partnerCommentData
{
    _partnerCommentData = partnerCommentData;
    if (partnerCommentData)
    {
        [self.userImg setImageWithURL:[NSURL URLWithString:partnerCommentData.userImg] placeholderImage:nil];
        self.userName.text = partnerCommentData.userName;
        self.time.text = partnerCommentData.time;
        self.commentContent.text = partnerCommentData.commentContent;

    }
}

- (void)layoutSubviews
{
    self.userImg.frame = CGRectMake(10, 5, 50, 50);
    self.userName.frame = CGRectMake(65, 5, 300, 20);
    self.time.frame = CGRectMake(65, 25, 200, 15);
    
    CGSize size = [CommonFuction sizeOfString:self.partnerCommentData.commentContent maxWidth:300 maxHeight:1000 withFontSize:13.0f];
    self.commentContent.frame = CGRectMake(65, 40, 280, size.height);
    self.lineImg.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}

+ (CGFloat)height
{
    return 50.0f;
}
@end
