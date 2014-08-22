//
//  MajorDetailModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MajorDetailModel.h"

@implementation MajorDetailModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_MajorDetail_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.instituteId = [data objectForKey:@"instituteId"];
        self.institutename = [data objectForKey:@"institutename"];
        self.name = [data objectForKey:@"name"];
        self.majorId = [data objectForKey:@"majorId"];
        return YES;
    }
    return NO;
}

@end
