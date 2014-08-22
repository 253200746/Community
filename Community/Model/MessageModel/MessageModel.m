//
//  MessageModel.m
//  Community
//
//  Created by andy on 14-6-19.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetMessageList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

/*返回数据解析接口*/

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    NSDictionary *dataDic = [data objectForKey:@"data"];
    if (dataDic && [dataDic count] > 0)
    {
        
    }
    return YES;
}

@end
