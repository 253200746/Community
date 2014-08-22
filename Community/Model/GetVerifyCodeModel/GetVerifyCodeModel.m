//
//  GetVerifyCodeModel.m
//  Community
//
//  Created by Andy on 14-8-6.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "GetVerifyCodeModel.h"

@implementation GetVerifyCodeModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetVerifyCode_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] && [data count] > 0)
    {
        self.verifyStr = [data objectForKey:@"verifyStr"];
        return YES;
    }
    return NO;
}


@end
