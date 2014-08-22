//
//  InstituteListModel.m
//  Community
//
//  Created by Andy on 14-7-1.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "InstituteListModel.h"
#import "InstituteListModel.h"


@implementation InstituteListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:InstituteList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] &&  data && [data count] > 0)
    {
        NSArray *instituteArray = [data objectForKey:@"instituteList"];
        if (instituteArray && [instituteArray count] > 0)
        {
            if (_instituteMArray == nil)
            {
                _instituteMArray = [NSMutableArray array];
            }
            for (int nIndex = 0; nIndex < [instituteArray count]; nIndex++)
            {
//                NSDictionary *instituteDic = [instituteArray objectAtIndex:nIndex];
//                InstituteData *instituteData = [[InstituteData alloc] init];
//                instituteData.instituteId = [instituteDic objectForKey:@"instituteId"];
//                instituteData.name = [instituteDic objectForKey:@"name"];
//                [self.instituteMArray addObject:instituteData];
            }
        }
        return YES;
    }
    return NO;
}

@end
