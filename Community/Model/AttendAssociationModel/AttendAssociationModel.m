//
//  AttendAssociationModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "AttendAssociationModel.h"

@implementation AttendAssociationModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:AttendAssociation_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.fansId = [data objectForKey:@"fansId"];
        return YES;
    }
    return NO;
}
@end
