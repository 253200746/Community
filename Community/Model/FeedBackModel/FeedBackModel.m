//
//  FeedBackModel.m
//  Community
//
//  Created by Andy on 14-8-19.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "FeedBackModel.h"

@implementation FeedBackModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:FeedBack_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"])
    {
        return YES;
    }
    return NO;
}

@end
