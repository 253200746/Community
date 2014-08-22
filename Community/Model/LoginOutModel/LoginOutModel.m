//
//  LoginOutModel.m
//  Community
//
//  Created by Andy on 14-7-20.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "LoginOutModel.h"

@implementation LoginOutModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:LoginOut_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] &&  data && [data count] > 0)
    {
        return YES;
    }
    return NO;
}


@end
