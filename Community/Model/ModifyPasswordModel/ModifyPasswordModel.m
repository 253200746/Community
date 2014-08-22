//
//  ModifyPasswordModel.m
//  Community
//
//  Created by Andy on 14-8-9.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ModifyPasswordModel.h"

@implementation ModifyPasswordModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:FindPassword_Method httpHeader:nil httpBody:params success:success fail:fail];
}

@end
