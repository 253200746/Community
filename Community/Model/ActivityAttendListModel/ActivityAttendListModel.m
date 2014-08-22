//
//  ActivityAttendListModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityAttendListModel.h"

@implementation AttendPerson

@end

@implementation ActivityAttendListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_ActivityAttendList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        NSArray *activityAttendList = [data objectForKey:@"activityAttendList"];
        if (activityAttendList && [activityAttendList count])
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            [_dataMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [activityAttendList count]; nIndex++)
            {
                NSDictionary *activityAttendDic = [activityAttendList objectAtIndex:nIndex];
                AttendPerson *attendPerson = [[AttendPerson alloc] init];
                attendPerson.userId = [activityAttendDic objectForKey:@"userId"];
                attendPerson.userImgUrl = [activityAttendDic objectForKey:@"userImgUrl"];
                attendPerson.time = [activityAttendDic objectForKey:@"time"];
                attendPerson.nickName = [activityAttendDic objectForKey:@"nickName"];
                [self.dataMArray addObject:attendPerson];
            }
            
        }
        return YES;
    }
    return NO;
}

@end
