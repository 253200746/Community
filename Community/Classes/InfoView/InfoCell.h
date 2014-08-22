//
//  InfoCell.h
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface InfoCell : UITableViewCell

@property (nonatomic,strong) NewsData *newsData;
+ (CGFloat)height;

@end
