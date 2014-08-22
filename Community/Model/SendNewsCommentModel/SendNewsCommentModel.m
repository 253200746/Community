//
//  SendNewsCommentModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "SendNewsCommentModel.h"

@implementation SendNewsCommentModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Send_NewsComment_Mehtod httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.commentId = [data objectForKey:@"commentId"];
        return YES;
    }
    return NO;
}
@end
