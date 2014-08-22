//
//  PartnerFansCell.m
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerFansCell.h"
#import "EWPIconButton.h"
#import "UIImageView+WebCache.h"
#import "PartnerLikeListModel.h"


@implementation LikeIconBtn

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(85, 10, contentRect.size.width-70, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(40, 9, 24, 21);
}

@end


@interface PartnerFansCell ()
@property (nonatomic,strong) UIScrollView *scroolView;
@property (nonatomic,strong) UIImageView *lineImg;
@end
@implementation PartnerFansCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _scroolView = [[UIScrollView alloc] init];
        [self.contentView addSubview:_scroolView];
        
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lineImg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLikeFansList:(NSArray *)likeFansList
{
    _likeFansList = likeFansList;
    if (likeFansList && [likeFansList count])
    {
        int nWidth = 30;
        int nHeight = 30;
        int nSpace = 5;
        int displayCount = [likeFansList count] > 7? 7 :[likeFansList count];
        for (int nIndex = 0; nIndex < displayCount; nIndex++)
        {
            PartnerLikeData *likeData = [likeFansList objectAtIndex:nIndex];
            int xPos = nWidth * nIndex + nSpace * nIndex;
            UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, 5, nWidth, nHeight)];
            [headImg setImageWithURL:[NSURL URLWithString:likeData.imgurl] placeholderImage:nil];
            headImg.backgroundColor = [UIColor redColor];
            [self.scroolView addSubview:headImg];
        }
        LikeIconBtn *likeBtn = [LikeIconBtn buttonWithType:UIButtonTypeCustom];
        [likeBtn setImage:[UIImage imageNamed:@"likeNormal"] forState:UIControlStateNormal];
        [likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [likeBtn setTitle:[NSString stringWithFormat:@"%d",[likeFansList count]] forState:UIControlStateNormal];
        likeBtn.frame = CGRectMake((nWidth + nSpace) * 6, 0, 50, 20);
        [self.scroolView  addSubview:likeBtn];
    }
}

- (void)layoutSubviews
{
    self.scroolView.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
    self.lineImg.frame = CGRectMake(10, self.frame.size.height - 1, self.frame.size.width - 20, 1);
}

+ (CGFloat)height
{
    return 40.0f;
}
@end
