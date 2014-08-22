//
//  NewsDetailModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_NewsDetail_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.newsId = [data objectForKey:@"newsId"];
        self.schoolId = [data objectForKey:@"schoolId"];
        self.schoolName = [data objectForKey:@"schoolName"];
        self.infoName = [data objectForKey:@"infoName"];
        self.associationId = [data objectForKey:@"associationId"];
        self.associatioNname = [data objectForKey:@"associatioNname"];
        self.typeId = [data objectForKey:@"typeId"];
        self.typeName = [data objectForKey:@"typeName"];
        self.imgUrl = [data objectForKey:@"imgUrl"];
        self.content = [data objectForKey:@"content"];
        self.time = [data objectForKey:@"time"];
        self.systemtime = [data objectForKey:@"systemtime"];
        self.commentNum = [data objectForKey:@"commentNum"];
        self.clickRate = [data objectForKey:@"clickRate"];
        return YES;
    }
    return NO;
}
@end
