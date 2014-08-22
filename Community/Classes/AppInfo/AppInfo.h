//
//  AppInfo.h
//  Community
//
//  Created by Andy on 14-7-7.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *schoolName;
@property (nonatomic,assign) BOOL bLoginSuccess;
@property (nonatomic,strong) NSString *deviceToken;
+ (AppInfo *)shareAppInfoManager;
@end
