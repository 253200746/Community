//
//  MessageCell.m
//  Community
//
//  Created by andy on 14-6-19.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageData
@end

@interface MessageCell ()
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *messageTitleLable;
@property (nonatomic,strong) UILabel *messageSummaryLable;
@property (nonatomic,strong) UIImageView *lineImageView;

@end
@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_headImageView];
        
        _messageTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_messageTitleLable];
        
        _messageSummaryLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageSummaryLable.font = [UIFont systemFontOfSize:14.0f];
        _messageSummaryLable.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_messageSummaryLable];
        
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lineImageView];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessageData:(MessageData *)messageData
{
    _messageData = messageData;
    [self.headImageView setImageWithURL:[NSURL URLWithString:messageData.imgeUrl] placeholderImage:nil];
    self.messageTitleLable.text = messageData.messageTitle;
    self.messageSummaryLable.text = messageData.messageSummary;
}

- (void)layoutSubviews
{
    self.headImageView.frame = CGRectMake(10, 5, 40, 40);
    self.messageTitleLable.frame = CGRectMake(70, 5, self.frame.size.width - 70, 20);
    self.messageSummaryLable.frame = CGRectMake(70, 25, self.frame.size.width - 70, 20);
    self.lineImageView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}

+ (CGFloat)height
{
    return 50.0f;
}
@end
