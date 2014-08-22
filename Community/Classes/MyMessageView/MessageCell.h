//
//  MessageCell.h
//  Community
//
//  Created by andy on 14-6-19.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "CommonFuction.h"

@interface MessageData : NSObject
@property (nonatomic,assign) NSInteger messageType;
@property (nonatomic,strong) NSString *imgeUrl;
@property (nonatomic,strong) NSString *messageTitle;
@property (nonatomic,strong) NSString *messageSummary;
@property (nonatomic,strong) NSString *messageContent;
@end

@interface MessageCell : UITableViewCell
@property (nonatomic,strong) MessageData *messageData;
+ (CGFloat)height;
@end
