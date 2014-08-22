//
//  UserInfoManager.m
//  Community
//
//  Created by Andy on 14-7-4.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "UserInfoManager.h"


@implementation UserInfoManager

+ (UserInfoManager *)shareUserInfoManager
{
    static dispatch_once_t predicate;
    static UserInfoManager* instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
