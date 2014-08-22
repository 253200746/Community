//
//  PartnerFansCell.h
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeIconBtn : UIButton

@end

@interface PartnerFansCell : UITableViewCell
@property (nonatomic,strong) NSArray *likeFansList;
+ (CGFloat)height;
@end
