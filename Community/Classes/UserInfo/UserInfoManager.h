//
//  UserInfoManager.h
//  Community
//
//  Created by Andy on 14-7-4.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserInfoManager : NSObject
@property (nonatomic,strong) UserInfo *userInfo;


+ (UserInfoManager *)shareUserInfoManager;

@end
