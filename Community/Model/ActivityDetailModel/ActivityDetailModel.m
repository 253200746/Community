//
//  ActivityDetailModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityDetailModel.h"

@implementation ActivityDetailModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_ActivityDetail_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.isInterested = [data objectForKey:@"isInterested"];
        self.isAttend = [data objectForKey:@"isAttend"];
        self.associationId = [data objectForKey:@"associationId"];
        self.associationName = [data objectForKey:@"associationName"];
        self.memberNum = [data objectForKey:@"memberNum"];
        self.interestedNum = [data objectForKey:@"interestedNum"];
        self.attendNum = [data objectForKey:@"attendNum"];
        self.commentNum = [data objectForKey:@"commentNum"];
        self.clickRate = [data objectForKey:@"clickRate"];
        self.activityId = [data objectForKey:@"activityId"];
        self.applyStartTime = [data objectForKey:@"applyStartTime"];
        self.applyFinishTime = [data objectForKey:@"applyFinishTime"];
        self.starttime = [data objectForKey:@"starttime"];
        self.endtime = [data objectForKey:@"endtime"];
        self.systemtime = [data objectForKey:@"systemtime"];
        self.intro = [data objectForKey:@"intro"];
        self.clickRate = [data objectForKey:@"clickRate"];
        self.activityId = [data objectForKey:@"activityId"];
        self.sponsor = [data objectForKey:@"sponsor"];
        self.organizer = [data objectForKey:@"organizer"];
        self.address = [data objectForKey:@"address"];
        self.detailInfo = [data objectForKey:@"detailInfo"];
        self.imgUrl = [data objectForKey:@"imgUrl"];
        self.schoolId = [data objectForKey:@"schoolId"];
        self.schoolName = [data objectForKey:@"schoolName"];
        self.instituteId = [data objectForKey:@"instituteId"];
        self.instituteName = [data objectForKey:@"instituteName"];
        self.type = [data objectForKey:@"type"];
        self.name = [data objectForKey:@"name"];
        
        return YES;
    }
    return NO;
}

@end
