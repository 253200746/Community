//
//  OrganizationModel.m
//  Community
//
//  Created by Andy on 14-7-13.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "OrganizationModel.h"

@implementation OrganizationData

@end

@implementation OrganizationModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_OrganiztionList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        if (_dataMArray == nil)
        {
            _dataMArray = [NSMutableArray array];
        }
        [_dataMArray removeAllObjects];
        
        [_dataMArray removeAllObjects];
        NSArray *associationArray = [data objectForKey:@"associationList"];
        if (associationArray && associationArray)
        {
            for (int nIndex = 0; nIndex < [associationArray count]; nIndex++)
            {
                NSDictionary *associationDic = [associationArray objectAtIndex:nIndex];
                if (associationDic && [associationDic count])
                {
                    OrganizationData *data = [[OrganizationData alloc] init];
                    data.associationId = [associationDic objectForKey:@"associationId"];
                    data.attention = [associationDic objectForKey:@"attention"];
                    data.fansNum = [associationDic objectForKey:@"fansNum"];
                    data.imgUrl = [associationDic objectForKey:@"imgUrl"];
                    data.memberNum = [associationDic objectForKey:@"memberNum"];
                    data.name = [associationDic objectForKey:@"name"];
                    
                    [self.dataMArray addObject:data];
                }
            }
        }
        
        return YES;
    }
    return NO;
}
@end
