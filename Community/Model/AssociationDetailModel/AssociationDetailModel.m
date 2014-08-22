//
//  AssociationDetailModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "AssociationDetailModel.h"

@implementation AssociationDetailModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_AssociationDetail_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.schoolName = [data objectForKey:@"schoolName"];
        self.schoolId = [data objectForKey:@"schoolId"];
        self.fansNum = [data objectForKey:@"fansNum"];
        self.memberNum = [data objectForKey:@"memberNum"];
        self.intro = [data objectForKey:@"intro"];
        self.associationName = [data objectForKey:@"associationName"];
        self.associationImgUrl = [data objectForKey:@"associationImgUrl"];
        self.associationId = [data objectForKey:@"associationId"];
        self.attention = [data objectForKey:@"attention"];
        return YES;
    }
    return NO;
}
@end
