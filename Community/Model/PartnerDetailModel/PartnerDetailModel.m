//
//  PartnerDetailModel.m
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerDetailModel.h"

@implementation PartnerDetailModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Partner_Detail_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] && [data count] > 0)
    {
        self.clickRate = [data objectForKey:@"clickRate"];
        self.clickRate = [data objectForKey:@"commentNum"];
        self.clickRate = [data objectForKey:@"content"];
        self.clickRate = [data objectForKey:@"imgurl"];
        self.clickRate = [data objectForKey:@"isStartTel"];
        self.clickRate = [data objectForKey:@"likeNum"];
        self.clickRate = [data objectForKey:@"partnerId"];
        self.clickRate = [data objectForKey:@"systemtime"];
        self.clickRate = [data objectForKey:@"telphone"];
        self.clickRate = [data objectForKey:@"time"];
        self.clickRate = [data objectForKey:@"typeId"];
        self.clickRate = [data objectForKey:@"typeName"];
        self.clickRate = [data objectForKey:@"userId"];
        self.clickRate = [data objectForKey:@"userImgUrl"];
        self.clickRate = [data objectForKey:@"userName"];
        self.clickRate = [data objectForKey:@"youisLike"];
        return YES;
    }
    return NO;
}
@end
