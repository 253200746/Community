//
//  ApplyActivityInfoCell.m
//  Community
//
//  Created by andy on 14-8-22.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ApplyActivityInfoCell.h"
#import "PersonInfoCell.h"

@interface ApplyActivityInfoCell ()
@property (nonatomic,strong) NSMutableArray *personMArray;
@end

@implementation ApplyActivityInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _personMArray = [NSMutableArray array];
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

- (void)setApplyActivityInfos:(NSMutableArray *)applyActivityInfos
{
    if (applyActivityInfos && [applyActivityInfos count])
    {
        for (int nIndex = 0; nIndex < [applyActivityInfos count]; nIndex++)
        {
            AttendPerson *personInfo = [applyActivityInfos objectAtIndex:nIndex];
            PersonInfoCell *personInfoCell = [[PersonInfoCell alloc] init];
            personInfoCell.personInfo = personInfo;
            [self.contentView addSubview:personInfoCell];
            [self.personMArray addObject:personInfoCell];
        }
    }
}

- (void)layoutSubviews
{
    for (int nIndex = 0; nIndex < [self.personMArray count]; nIndex++)
    {
        int nSpace = 20;
        int nWidth = 60;
        int nHeight = 100;
        int xPos = 10 + nIndex * (nWidth + nSpace);
        int yPos = 10;
        PersonInfoCell *personCell = [self.personMArray objectAtIndex:nIndex];
        personCell.frame = CGRectMake(xPos, yPos, nWidth, nHeight);
        
    }
}

+ (CGFloat)height
{
    return 100.0f;
}

@end
