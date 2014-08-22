//
//  ToolListModel.m
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ToolListModel.h"

@implementation ToolData

@end

@implementation ToolListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Tool_List_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] && [data count] > 0)
    {
        NSArray *daojus = [data objectForKey:@"daojus"];
        if (daojus && [daojus count])
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            [_dataMArray removeAllObjects];

            for (int nIndex = 0; nIndex < [daojus count]; nIndex++)
            {
                NSDictionary *toolDic = [daojus objectAtIndex:nIndex];
                if (toolDic && [toolDic count])
                {
                    ToolData *toolData = [[ToolData alloc] init];
                    toolData.argument = [toolDic objectForKey:@"argument"];
                    toolData.argumentnumber = [toolDic objectForKey:@"argumentnumber"];
                    toolData.img = [toolDic objectForKey:@"img"];
                    toolData.name = [toolDic objectForKey:@"name"];
                    toolData.url = [toolDic objectForKey:@"url"];
                    [self.dataMArray addObject:toolData];
                }
            }
            
        }
        return YES;
    }
    return NO;
}
@end
