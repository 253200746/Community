//
//  AssociationModel.m
//  Community
//
//  Created by Andy on 14-7-9.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "AssociationModel.h"

@implementation AssociationData

@end

@implementation AssociationModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_NewsList_Method httpHeader:nil httpBody:params success:success fail:fail];
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

        return YES;
    }
    return NO;
}

@end
