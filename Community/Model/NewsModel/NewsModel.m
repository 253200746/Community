//
//  NewsModel.m
//  Community
//
//  Created by Andy on 14-7-7.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsData

@end

@implementation NewsModel
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
        NSArray *dataArray = [data objectForKey:@"newsList"];
        if (dataArray && [dataArray count])
        {
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *dataDic = [dataArray objectAtIndex:nIndex];
                NewsData *newsData = [[NewsData alloc] init];

                newsData.associationId = [dataDic objectForKey:@"associationId"];
                newsData.associationName = [dataDic objectForKey:@"associationName"];
                newsData.campusId = [dataDic objectForKey:@"campusId"];
                newsData.campusName = [dataDic objectForKey:@"campusName"];
                newsData.clickRate = [dataDic objectForKey:@"clickRate"];
                newsData.commentNum = [dataDic objectForKey:@"commentNum"];
                newsData.content = [dataDic objectForKey:@"content"];
                newsData.imgUrl = [dataDic objectForKey:@"imgUrl"];
                newsData.infoName = [dataDic objectForKey:@"infoName"];
                newsData.isListisTop = [dataDic objectForKey:@"isListisTop"];
                newsData.newsId = [dataDic objectForKey:@"newsId"];
                newsData.systemtime = [dataDic objectForKey:@"systemtime"];
                newsData.time = [dataDic objectForKey:@"time"];
                NSDictionary *typeDic = [dataDic objectForKey:@"type"];
                if (typeDic && [typeDic count])
                {
                    TypeData *typeData = [[TypeData alloc] init];
                    typeData.typeId = [[typeDic objectForKey:@"typeId"] integerValue];
                    typeData.typeName = [typeDic objectForKey:@"name"];
                    newsData.type = typeData;
                }
                [self.dataMArray addObject:newsData];
            }
            
        }
        return YES;
    }
    return NO;
}
@end
