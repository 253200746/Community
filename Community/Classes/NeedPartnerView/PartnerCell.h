//
//  PartnerCell.h
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeedPartnerListModel.h"

@interface PartnerCell : UITableViewCell
@property (nonatomic,assign) BOOL bShowDetailParnter;

@property (nonatomic,strong) PartnerData *partnerData;
+ (CGFloat)height;

@end
