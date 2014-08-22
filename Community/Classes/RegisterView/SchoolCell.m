//
//  SchoolCell.m
//  Community
//
//  Created by Andy on 14-6-30.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "SchoolCell.h"

@implementation DetailButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(25, 0, contentRect.size.width-24, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(5, 3, 15, 15);
}

@end

@interface SchoolCell ()
@property (nonatomic,strong) DetailButton *detailBtn;
@property (nonatomic,strong) UILabel *schoolTitle;
@property (nonatomic,strong) UIImageView *arrow;
@end

@implementation SchoolCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _detailBtn = [DetailButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setImage:[UIImage imageNamed:@"icon_info.png"] forState:UIControlStateNormal];
        [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_detailBtn];
        
        _schoolTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_schoolTitle];
        
        _arrow = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrow.image = [UIImage imageNamed:@"arrow.png"];
        [self.contentView addSubview:_arrow];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSchoolData:(SchoolData *)schoolData
{
    _schoolData = schoolData;
    self.textLabel.text = schoolData.name;
    if (schoolData)
    {
        self.schoolTitle.text = schoolData.name;
    }
    else
    {
        if (self.schoolCellType == 0)
        {
            self.schoolTitle.text = @"您尚未登录";
        }
    }
}

- (void)layoutSubviews
{
    self.detailBtn.frame = CGRectMake(5, 10, 60, 20);
    self.schoolTitle.frame = CGRectMake(70, 0, self.frame.size.width - 70 - 22, self.frame.size.height);
    self.arrow.frame = CGRectMake(self.frame.size.width - 22, 10, 12, 20);
}

+ (CGFloat)height
{
    return 40.0f;
}

@end
