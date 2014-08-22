//
//  MajorListModel.m
//  Community
//
//  Created by Andy on 14-7-1.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MajorListModel.h"

@implementation MajorData

@end

@implementation MajorListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:MajorList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] &&  data && [data count] > 0)
    {
        NSArray *majorArray = [data objectForKey:@"majorList"];
        if (majorArray && [majorArray count] > 0)
        {
            if (_majorMArray == nil)
            {
                _majorMArray = [NSMutableArray array];
            }
            for (int nIndex = 0; nIndex < [majorArray count]; nIndex++)
            {
                NSDictionary *majorDic = [majorArray objectAtIndex:nIndex];
                MajorData *majorData = [[MajorData alloc] init];
                majorData.majorId = [majorDic objectForKey:@"majorId"];
                majorData.name = [majorDic objectForKey:@"name"];
                [self.majorMArray addObject:majorData];
            }
        }

        return YES;
    }
    return NO;
}

@end
