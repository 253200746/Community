//
//  BaseModel.m
//  Community
//
//  Created by andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)requestDataWithMethod:(NSString *)method httpHeader:(NSDictionary *)httpHeader httpBody:(NSDictionary *)httpBody success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithBaseUrl:Server_BaseUrl method:method httpHeader:httpHeader httpBody:httpBody success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (data && [data count] > 0)
    {
        self.message = [data objectForKey:@"message"];
        self.resultCode = [data objectForKey:@"resultCode"];
        self.rootMessage = [data objectForKey:@"rootMessage"];
        self.errorMessage = [data objectForKey:@"errorMessage"];
    }
    return YES;
}

@end
