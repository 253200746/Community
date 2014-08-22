//
//  ModifyUserInfoModel.m
//  Community
//
//  Created by Andy on 14-7-23.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ModifyUserInfoModel.h"

@implementation ModifyUserInfoModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Modify_UserInfo_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] &&  data && [data count] > 0)
    {
        self.userLoginName = [data objectForKey:@"userLoginName"];
        return YES;
    }
    return NO;
}


@end
