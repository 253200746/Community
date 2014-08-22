//
//  ActivityModel.m
//  Community
//
//  Created by Andy on 14-6-19.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetActivityList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] &&  data && [data count] > 0)
    {
        if (_dataMArray == nil)
        {
            _dataMArray = [NSMutableArray array];
        }
        [_dataMArray removeAllObjects];
        NSArray *dataArray = [data objectForKey:@"activityList"];
        if (dataArray && [dataArray count])
        {
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *dataDic = [dataArray objectAtIndex:nIndex];
                ActivityData *data = [[ActivityData alloc] init];
                data.activityId = [dataDic objectForKey:@"activityId"];
                data.address = [dataDic objectForKey:@"address"];
                data.applyFinishTime = [dataDic objectForKey:@"applyFinishTime"];
                data.applyStartTime = [dataDic objectForKey:@"applyStartTime"];
                data.attendNum = [dataDic objectForKey:@"attendNum"];
                data.begindays = [dataDic objectForKey:@"begindays"];
                data.clickRate = [dataDic objectForKey:@"clickRate"];
                data.commentNum = [dataDic objectForKey:@"commentNum"];
                data.detailInfo = [dataDic objectForKey:@"detailInfo"];
                data.endTime = [dataDic objectForKey:@"endtime"];
                data.imgUrl = [dataDic objectForKey:@"imgUrl"];
                data.interestedNum = [dataDic objectForKey:@"interestedNum"];
                data.isListisTop = [dataDic objectForKey:@"isListisTop"];
                data.name = [dataDic objectForKey:@"name"];
                data.sponsor = [dataDic objectForKey:@"sponsor"];
                data.startTime = [dataDic objectForKey:@"starttime"];
                data.systemtime = [dataDic objectForKey:@"systemtime"];
                data.type = [dataDic objectForKey:@"type"];
                
                [self.dataMArray addObject:data];
            }
        }
        
        return YES;
    }
    return NO;
}

@end
