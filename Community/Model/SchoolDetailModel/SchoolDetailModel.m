//
//  SchoolDetailModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "SchoolDetailModel.h"

@implementation SchoolDetailModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_SchoolDetail_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.schoolId = [data objectForKey:@"schoolId"];
        self.schooName = [data objectForKey:@"schooName"];
        self.schoolShortName = [data objectForKey:@"schoolShortName"];
        self.leader = [data objectForKey:@"leader"];
        self.descInfo = [data objectForKey:@"descInfo"];
        self.schoolAddr = [data objectForKey:@"schoolAddr"];
        self.zipcode = [data objectForKey:@"zipcode"];
        self.provinceId = [data objectForKey:@"provinceId"];
        self.provinceName = [data objectForKey:@"provinceName"];
        self.cityId = [data objectForKey:@"cityId"];
        self.cityName = [data objectForKey:@"cityName"];
        self.areaId = [data objectForKey:@"areaId"];
        self.areaName = [data objectForKey:@"areaName"];
        self.headcount = [data objectForKey:@"headcount"];
        self.logoUrl = [data objectForKey:@"logoUrl"];
        return YES;
    }
    return NO;
}

@end
