//
//  InstituteDetailModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "InstituteDetailModel.h"

@implementation InstituteDetailModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_InstituteDetail_Method httpHeader:nil httpBody:params success:success fail:fail];
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
        self.name = [data objectForKey:@"name"];
        self.ShortName = [data objectForKey:@"ShortName"];
        self.schoolId = [data objectForKey:@"schoolId"];
        return YES;
    }
    return NO;
}
@end
