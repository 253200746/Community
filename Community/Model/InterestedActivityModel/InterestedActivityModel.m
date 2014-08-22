//
//  InterestedActivityModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "InterestedActivityModel.h"

@implementation InterestedActivityModel

- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:InterestedActivity_Method httpHeader:nil httpBody:params success:success fail:fail];
}
@end
