//
//  TypeModel.m
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "TypeModel.h"

@implementation TypeData

@end

@implementation TypeModel

- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetTypeList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        if (_typeMArray == nil)
        {
            _typeMArray = [NSMutableArray array];
        }
        [_typeMArray removeAllObjects];
        
        NSArray *typeList = [data objectForKey:@"typeList"];
        if (typeList && [typeList count] > 0)
        {
            for (int nIndex = 0; nIndex < [typeList count]; nIndex++)
            {
                NSDictionary *typeDic = [typeList objectAtIndex:nIndex];
                TypeData *typeData = [[TypeData alloc] init];
                typeData.typeId = [[typeDic objectForKey:@"id"] integerValue];
                typeData.typeName = [typeDic objectForKey:@"name"];
                [self.typeMArray addObject:typeData];
            }
        }
        return YES;
    }
    return NO;
}

@end
