//
//  PersonInfoCell.m
//  Community
//
//  Created by andy on 14-8-22.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PersonInfoCell.h"
#import "UIImageView+WebCache.h"

@interface PersonInfoCell ()
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nickName;
@end
@implementation PersonInfoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImg.backgroundColor = [UIColor redColor];
        [self addSubview:_headImg];
        
        _nickName = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickName.font = [UIFont systemFontOfSize:11.0f];
        _nickName.textColor = [UIColor grayColor];
        _nickName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nickName];
        
    }
    return self;
}

- (void)setPersonInfo:(AttendPerson *)personInfo
{
    if (personInfo)
    {
        if (personInfo.userImgUrl)
        {
            [self.headImg setImageWithURL:[NSURL URLWithString:personInfo.userImgUrl] placeholderImage:nil];
        }
        
        if (personInfo)
        {
            self.nickName.text = personInfo.nickName;
        }
        
    }
}

- (void)layoutSubviews
{
    self.headImg.frame = CGRectMake(5, 5, 50, 50);
    self.nickName.frame = CGRectMake(5, 60, 50, 15);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
