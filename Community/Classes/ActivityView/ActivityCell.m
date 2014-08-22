//
//  ActivityCell.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityCell.h"
#import "EWPIconLable.h"
#import "UIImageView+WebCache.h"

@implementation ActivityData

@end

@interface ActivityCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *titleBKView;
@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UIView *contentBKView;
@property (nonatomic,strong) UIImageView *activityImageView;
@property (nonatomic,strong) EWPIconLable *beginTime;
@property (nonatomic,strong) EWPIconLable *endTime;
@property (nonatomic,strong) EWPIconLable *place;
@property (nonatomic,strong) EWPIconLable *type;

@property (nonatomic,strong) UILabel *attendNumLable;
@property (nonatomic,strong) UILabel *interestedNumLable;
@property (nonatomic,strong) UILabel *beginNumlable;

@property (nonatomic,strong) UILabel *attendLable;
@property (nonatomic,strong) UILabel *interestedLable;
@property (nonatomic,strong) UILabel *beginlable;
@end


@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.layer.borderColor = [CommonFuction colorFromHexRGB:@"D1F3C0"].CGColor;
        _backView.layer.cornerRadius = 8.0f;
        _backView.layer.borderWidth = 1.0f;
        [self.contentView addSubview:_backView];
        
        self.backgroundColor = [UIColor clearColor];
        _titleBKView = [[UIView alloc] initWithFrame:CGRectZero];
        _titleBKView.backgroundColor = [CommonFuction colorFromHexRGB:@"D1F3C0"];
        [_backView addSubview:_titleBKView];
        
        _title = [[UILabel alloc] initWithFrame:_titleBKView.bounds];
        [_titleBKView addSubview:_title];
        
        _contentBKView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentBKView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:_contentBKView];
        
        _activityImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_contentBKView addSubview:_activityImageView];
        
        _beginTime = [[EWPIconLable alloc] initWithFrame:CGRectZero icon:nil title:nil];
        _beginTime.textSize = 12.0f;
        _beginTime.textXOffset = 2;
        [_contentBKView addSubview:_beginTime];
        
        _endTime = [[EWPIconLable alloc] initWithFrame:CGRectZero icon:nil title:nil];
        _endTime.textSize = 12.0f;
        _endTime.textXOffset = 2;
        [_contentBKView addSubview:_endTime];
        
        _place = [[EWPIconLable alloc] initWithFrame:CGRectZero icon:nil title:nil];
        _place.textSize = 12.0f;
        _place.textXOffset = 2;
        [_contentBKView addSubview:_place];
        
        _type = [[EWPIconLable alloc] initWithFrame:CGRectZero icon:nil title:nil];
        _type.textSize = 12.0f;
        _type.textXOffset = 2;
        [_contentBKView addSubview:_type];
        
        _attendNumLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _attendNumLable.font = [UIFont systemFontOfSize:12.0f];
        _attendNumLable.textAlignment = NSTextAlignmentRight;
        _attendNumLable.textColor = [CommonFuction colorFromHexRGB:@"F88818"];
        [_contentBKView addSubview:_attendNumLable];
        
        _attendLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _attendLable.font = [UIFont systemFontOfSize:12.0f];
        _attendLable.text = @"参加";
        _attendLable.textColor = [UIColor blackColor];
        [_contentBKView addSubview:_attendLable];
        
        _interestedNumLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _interestedNumLable.font = [UIFont systemFontOfSize:12.0f];
        _interestedNumLable.textAlignment = NSTextAlignmentRight;
        _interestedNumLable.textColor = [CommonFuction colorFromHexRGB:@"F88818"];
        [_contentBKView addSubview:_interestedNumLable];
        
        _interestedLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _interestedLable.font = [UIFont systemFontOfSize:12.0f];
        _interestedLable.text = @"感兴趣";
         _interestedLable.textColor = [UIColor blackColor];
        [_contentBKView addSubview:_interestedLable];
        
        _beginNumlable = [[UILabel alloc] initWithFrame:CGRectZero];
        _beginNumlable.font = [UIFont systemFontOfSize:12.0f];
        _beginNumlable.textAlignment = NSTextAlignmentRight;
        _beginNumlable.textColor = [CommonFuction colorFromHexRGB:@"F88818"];
        [_contentBKView addSubview:_beginNumlable];
        
        _beginlable = [[UILabel alloc] initWithFrame:CGRectZero];
        _beginlable.font = [UIFont systemFontOfSize:12.0f];
        _beginlable.text = @"天候开始";
         _beginlable.textColor = [UIColor blackColor];
        [_contentBKView addSubview:_beginlable];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setActivityData:(ActivityData *)activityData
{ 
    _activityData = activityData;
    if (activityData)
    {
        self.title.text = activityData.name;
        [self.activityImageView setImageWithURL:[NSURL URLWithString:activityData.imgUrl] placeholderImage:nil];
        [self.beginTime SetTitle:[activityData.startTime substringToIndex:([activityData.startTime length] - 3)] icon:[UIImage imageNamed:@"time.png"]];
        [self.endTime SetTitle:[activityData.endTime substringToIndex:([activityData.endTime length] - 3)] icon:[UIImage imageNamed:@"time.png"]];
        [self.place SetTitle:activityData.address icon:[UIImage imageNamed:@"place.png"]];
        [self.type SetTitle:[NSString stringWithFormat:@"类型:%@",activityData.type] icon:[UIImage imageNamed:@"type"]];
        
        self.attendNumLable.text = activityData.attendNum;
        self.interestedNumLable.text = activityData.interestedNum;
        if ([activityData.begindays integerValue] < 0)
        {
            self.beginNumlable.text = @"0";
        }
        else
        {
            self.beginNumlable.text = activityData.begindays;
        }
        
    }
}

- (void)layoutSubviews
{
    self.backView.frame = CGRectMake(10, 10, 300, 130);
    self.titleBKView.frame = CGRectMake(0, 0, self.backView. frame.size.width, 30);
    self.title.frame = CGRectMake(5, 5, self.backView.frame.size.width, 20);
    
    self.contentBKView.frame = CGRectMake(0, 30, self.backView.frame.size.width, [ActivityCell height] - 40 - 10);
    self.activityImageView.frame = CGRectMake(5, 5, 70, 90);
    self.beginTime.frame = CGRectMake(80, 5, self.backView.frame.size.width - 80, 15);
    self.endTime.frame = CGRectMake(80, 25, self.backView.frame.size.width - 80, 15);
    self.place.frame = CGRectMake(80, 45, self.backView.frame.size.width - 80, 15);
    self.type.frame = CGRectMake(80, 65, self.backView.frame.size.width - 80, 15);
    
    self.attendNumLable.frame = CGRectMake(105, 80, 25, 15);
    self.attendLable.frame = CGRectMake(130, 80, 25, 15);
    
    self.interestedNumLable.frame = CGRectMake(155, 80, 25, 15);
    self.interestedLable.frame = CGRectMake(180, 80, 40, 15);
    
    self.beginNumlable.frame = CGRectMake(220, 80, 25, 15);
    self.beginlable.frame = CGRectMake(245, 80, 50, 15);
}

+ (CGFloat)height
{
    return 150.0f;
}

@end
