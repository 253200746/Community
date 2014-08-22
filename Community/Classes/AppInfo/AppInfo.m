//
//  AppInfo.m
//  Community
//
//  Created by Andy on 14-7-7.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo
+ (AppInfo *)shareAppInfoManager
{
    static dispatch_once_t predicate;
    static AppInfo* instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.bLoginSuccess = NO;
        self.schoolId = @"58";//暂时这样写
    }
    return self;
}
@end
