//
//  DeleteActivityCommentModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "DeleteActivityCommentModel.h"

@implementation DeleteActivityCommentModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Delete_ActivityComment_Method httpHeader:nil httpBody:params success:success fail:fail];
}

@end
