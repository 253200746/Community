//
//  RegisterModel.m
//  Community
//
//  Created by Andy on 14-6-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Register_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.userid = [data objectForKey:@"userid"];
        return YES;
    }
    return NO;
}

@end
