//
//  PartnerLikeListModel.m
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerLikeListModel.h"

@implementation PartnerLikeData

@end

@implementation PartnerLikeListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Partner_LikeList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] && [data count] > 0)
    {
        NSArray *likefansList = [data objectForKey:@"likefansList"];
        if (likefansList && [likefansList count])
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            [_dataMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [likefansList count]; nIndex++)
            {
                NSDictionary *likefanDic = [likefansList objectAtIndex:nIndex];
                if (likefanDic && [likefanDic count])
                {
                    PartnerLikeData *partnerLikeData = [[PartnerLikeData alloc] init];
                    partnerLikeData.imgurl = [likefanDic objectForKey:@"imgurl"];
                    partnerLikeData.name = [likefanDic objectForKey:@"name"];
                    partnerLikeData.partnerId = [likefanDic objectForKey:@"partnerId"];
                    partnerLikeData.times = [likefanDic objectForKey:@"times"];
                    partnerLikeData.userid = [likefanDic objectForKey:@"userid"];
                    [self.dataMArray addObject:partnerLikeData];
                }
            }
            
        }
        return YES;
    }
    return NO;
}

@end
