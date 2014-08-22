//
//  OrganizationCell.m
//  Community
//
//  Created by Andy on 14-6-21.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "OrganizationCell.h"
#import "UIButton+WebCache.h"

@interface OrganizationCell ()
@property (nonatomic,strong) NSMutableArray *buttonArray;
@end

@implementation OrganizationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization codeo
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrganizationArray:(NSArray *)organizationArray
{
    _organizationArray = organizationArray;
    if (organizationArray && [organizationArray count])
    {
        if (_buttonArray == nil)
        {
            _buttonArray = [NSMutableArray array];
        }
        for (int nButtonIndex = 0; nButtonIndex < [_buttonArray count]; nButtonIndex++)
        {
            UIButton *button = [_buttonArray objectAtIndex:nButtonIndex];
            [button removeFromSuperview];
        }
        [_buttonArray removeAllObjects];
        
        for (int nIndex = 0; nIndex < [organizationArray count]; nIndex++)
        {
            OrganizationData *data = [organizationArray objectAtIndex:nIndex];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImageWithURL:[NSURL URLWithString:data.imgUrl] forState:UIControlStateNormal placeholderImage:nil];
            [button addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
            title.backgroundColor = [UIColor blackColor];
            title.alpha  = 0.6;
            title.tag = [data.associationId integerValue];
            title.text = data.name;
            title.textColor = [UIColor whiteColor];
            title.textAlignment = NSTextAlignmentCenter;
            title.font = [UIFont systemFontOfSize:13.0f];
            [button addSubview:title];
            [self.contentView addSubview:button];
            [self.buttonArray addObject:button];
        }

    }
}

- (void)OnClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(organizationCell:didSelectWithAssociationId:)])
    {
        [self.delegate organizationCell:self didSelectWithAssociationId:[NSString stringWithFormat:@"%d",button.tag]];
    }
}

- (void)layoutSubviews
{
    int nButtonCount = [_buttonArray count];
    if (nButtonCount > 0)
    {
        int nWidth = 96;
        for (int nIndex = 0; nIndex < nButtonCount; nIndex++)
        {
            UIButton *button = [_buttonArray objectAtIndex:nIndex];
            if (button)
            {
                button.frame = CGRectMake(10 + nWidth *nIndex + nIndex * 5, 2, nWidth, nWidth);
                
                UILabel *title = (UILabel *)[button viewWithTag:(100 + nIndex)];
                title.frame = CGRectMake(0, button.frame.size.height - 20, button.frame.size.width, 20);
            }
        }
    }
}

+ (CGFloat)height
{
    return 100.0f;
}

@end
