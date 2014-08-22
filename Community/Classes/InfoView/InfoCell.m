//
//  InfoCell.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "InfoCell.h"
#import "EWPIconLable.h"
#import "UIImageView+WebCache.h"
#import "CommonFuction.h"

@interface InfoCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *photo;
@property (nonatomic,strong) UILabel *type;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UILabel *time;
@property (nonatomic,strong) UILabel *publisher;
@property (nonatomic,strong) EWPIconLable *clickNum;

@end
@implementation InfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 3;
        _backView.layer.borderWidth = 1;
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_backView];
        
        _photo = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_backView addSubview:_photo];
        
        _type = [[UILabel alloc] initWithFrame:CGRectZero];
        _type.backgroundColor = [UIColor blackColor];
        _type.alpha = 0.3;
        _type.font = [UIFont systemFontOfSize:14.0f];
        [_photo addSubview:_type];
        
        _name = [[UILabel alloc] initWithFrame:CGRectZero];
        _name.textColor = [CommonFuction colorFromHexRGB:@"4ABA44"];
        _name.font = [UIFont systemFontOfSize:15.0f];
        [_backView addSubview:_name];
        
        _content = [[UILabel alloc] initWithFrame:CGRectZero];
        _content.numberOfLines = 0;
        _content.lineBreakMode = NSLineBreakByWordWrapping;
        _content.font = [UIFont systemFontOfSize:13.0f];
        [_backView addSubview:_content];
        
        _time = [[UILabel alloc] initWithFrame:CGRectZero];
        _time.font = [UIFont systemFontOfSize:11.0f];
        _time.textColor = [UIColor lightGrayColor];
        [_backView addSubview:_time];
        
        _publisher = [[UILabel alloc] initWithFrame:CGRectZero];
        _publisher.font = [UIFont systemFontOfSize:11.0f];
        _publisher.textColor = [UIColor lightGrayColor];
        [_backView addSubview:_publisher];
        
        _clickNum = [[EWPIconLable alloc] initWithFrame:CGRectZero icon:nil title:nil];
        _clickNum.textSize = 11.0f;
        _clickNum.textXOffset = 3.0f;
        [_backView addSubview:_clickNum];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsData:(NewsData *)newsData
{
    _newsData = newsData;
    if (newsData)
    {
        [_photo setImageWithURL:[NSURL URLWithString:newsData.imgUrl] placeholderImage:nil];
        _type.text = newsData.type.typeName;
        _name.text = newsData.infoName;
        _content.text = newsData.content;
        _time.text = [newsData.time substringToIndex:([newsData.time length] - 8)];
        _publisher.text = [NSString stringWithFormat:@"发布方:%@",newsData.associationName];
        [_clickNum SetTitle:newsData.clickRate icon:[UIImage imageNamed:@"clickRate"]];
    }
}

- (void)layoutSubviews
{
    _backView.frame = CGRectMake(0, 5, self.frame.size.width, self.frame.size.height - 10);
    _photo.frame = CGRectMake(5, 5, 80, 80);
    
    _name.frame = CGRectMake(90, 5, _backView.frame.size.width - 120, 20);
    _content.frame = CGRectMake(90, 25, _backView.frame.size.width - 120, 45);
    
    _time.frame = CGRectMake(90, _backView.frame.size.height - 20, 120, 15);
    _publisher.frame = CGRectMake(150, _backView.frame.size.height - 20, 130, 15);
    
    _clickNum.frame = CGRectMake(280, _backView.frame.size.height - 20, 50, 15);
}

+ (CGFloat)height
{
    return 100.0f;
}
@end
