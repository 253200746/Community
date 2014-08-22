//
//  ActivityCell.h
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFuction.h"
#import "ActivityModel.h"

@interface ActivityCell : UITableViewCell

@property (nonatomic,strong) ActivityData *activityData;

+ (CGFloat)height;
@end
