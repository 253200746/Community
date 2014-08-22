//
//  PartnerCommentCell.h
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerCommentListModel.h"

@interface PartnerCommentCell : UITableViewCell
@property (nonatomic,strong) PartnerCommentData *partnerCommentData;
+ (CGFloat)height;
@end
