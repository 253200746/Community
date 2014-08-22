//
//  FindPasswordModel.m
//  Community
//
//  Created by Andy on 14-8-9.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "FindPasswordModel.h"

@implementation FindPasswordModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:FindPassword_Method httpHeader:nil httpBody:params success:success fail:fail];
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
