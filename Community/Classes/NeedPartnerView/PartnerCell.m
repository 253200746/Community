//
//  PartnerCell.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerCell.h"
#import "UIImageView+WebCache.h"
#import "PartnerIconBtn.h"
#import "CommentView.h"
#import "CommonFuction.h"

@interface PartnerCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *userImgView;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) CommentView *commentView;
@property (nonatomic,strong) PartnerIconBtn *telephonBtn;
@property (nonatomic,strong) PartnerIconBtn *commentBtn;
@property (nonatomic,strong) PartnerIconBtn *likeBtn;

@end
@implementation PartnerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.bShowDetailParnter = NO;
        
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.layer.cornerRadius = 5.0f;
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.borderColor = [CommonFuction colorFromHexRGB:@"D0D0D0"].CGColor;
        _backView.layer.borderWidth = 1.0f;
        [self.contentView addSubview:_backView];
        
        _userImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_backView addSubview:_userImgView];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectZero];
        _userName.font = [UIFont systemFontOfSize:13.0f];
        [_backView addSubview:_userName];
        
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shareNormal"] forState:UIControlStateNormal];
        [_backView addSubview:_shareBtn];
        
        _content = [[UILabel alloc] initWithFrame:CGRectZero];
        _content.font = [UIFont systemFontOfSize:11.0f];
        _content.lineBreakMode = 0;
        _content.textAlignment = NSTextAlignmentLeft;
        _content.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:_content];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_backView addSubview:_imgView];
        
        _commentView = [[CommentView alloc] initWithFrame:CGRectZero];
        _commentView.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:_commentView];
        
        _telephonBtn = [PartnerIconBtn buttonWithType:UIButtonTypeCustom];
        [_telephonBtn setImage:[UIImage imageNamed:@"telephonNormal"] forState:UIControlStateNormal];
        _telephonBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"D0D0D0"].CGColor;
        _telephonBtn.layer.borderWidth = 1;
        [_backView addSubview:_telephonBtn];
        
        _commentBtn = [PartnerIconBtn buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"commntNormal"] forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"D0D0D0"].CGColor;
        _commentBtn.layer.borderWidth = 1;
        [_backView addSubview:_commentBtn];
        
        _likeBtn = [PartnerIconBtn buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"likeNormal"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"D0D0D0"].CGColor;
        _likeBtn.layer.borderWidth = 1;
        [_backView addSubview:_likeBtn];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPartnerData:(PartnerData *)partnerData
{
    _partnerData = partnerData;
    if (partnerData)
    {
        if (partnerData.userImgUrl)
        {
            [self.userImgView setImageWithURL:[NSURL URLWithString:partnerData.userImgUrl] placeholderImage:nil];
        }
        NSString *content = [NSString stringWithFormat:@"[%@] %@",partnerData.typeName,partnerData.content];
        self.content.text = content;
        self.userName.text = partnerData.userName;
        if (self.bShowDetailParnter)
        {
             //此变量主要用于求伴详情复用，详情页面不显示。
            self.telephonBtn.hidden = YES;
            self.commentBtn.hidden = YES;
            self.likeBtn.hidden = YES;
           

        }
        else
        {
            self.telephonBtn.hidden = NO;
            self.commentBtn.hidden = NO;
            self.likeBtn.hidden = NO;
            
            [self.commentBtn setTitle:partnerData.commentNum forState:UIControlStateNormal];
            [self.likeBtn setTitle:partnerData.likeNum forState:UIControlStateNormal];
        }

    }
}

- (void)layoutSubviews
{
    CGFloat nYOffset = 10;
    self.backView.frame = CGRectMake(10, nYOffset, 300, self.frame.size.height - 10);
    self.userImgView.frame = CGRectMake(5, 5, 40, 40);
    self.userName.frame = CGRectMake(50, nYOffset, 100, 15);
    self.shareBtn.frame = CGRectMake(_backView.frame.size.width - 30, nYOffset, 20, 20);
    nYOffset += 40;
    self.content.frame = CGRectMake(5, nYOffset, 290, 50);
    nYOffset += 55;
    if (self.partnerData.imgurl && [self.partnerData.imgurl length]>0)
    {
        self.imgView.frame = CGRectMake(30, 105, 240, 150);
        nYOffset += 155;
    }
    
//    if (self.partnerData.commentNum && [self.partnerData.commentNum integerValue]> 0)
//    {
//        self.commentView.frame = CGRectMake(5, nYOffset, 290, 70);
//        nYOffset += 70;
//    }
    
    if(!self.bShowDetailParnter)
    {
        self.telephonBtn.frame = CGRectMake(0, self.backView.frame.size.height - 40, 100, 40);
        self.commentBtn.frame = CGRectMake(100, self.backView.frame.size.height - 40, 100, 40);
        self.likeBtn.frame = CGRectMake(200, self.backView.frame.size.height - 40, 100, 40);
    }
    else
    {
        self.telephonBtn.frame = CGRectZero;
        self.commentBtn.frame = CGRectZero;
        self.likeBtn.frame = CGRectZero;
    }

}

+ (CGFloat)height
{
    return 150.0f;
}
@end
