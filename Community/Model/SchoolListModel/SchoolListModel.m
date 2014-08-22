//
//  SchoolListModel.m
//  Community
//
//  Created by Andy on 14-6-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "SchoolListModel.h"

@implementation InstituteData

@end

@implementation SchoolData

@end

@implementation SchoolListModel

- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:SchollList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] &&  data && [data count] > 0)
    {
        NSArray *schoolList = [data objectForKey:@"schoolList"];
        if (schoolList && [schoolList count] > 0)
        {
            if (_schoolMArray == nil)
            {
                _schoolMArray = [NSMutableArray array];
            }
            [_schoolMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [schoolList count]; nIndex++)
            {
                NSDictionary *schoolDic = [schoolList objectAtIndex:nIndex];
                SchoolData *schoolData = [[SchoolData alloc] init];
                schoolData.schoolId = [schoolDic objectForKey:@"schoolId"];
                schoolData.name = [schoolDic objectForKey:@"name"];
                schoolData.logo = [schoolDic objectForKey:@"logo"];
                schoolData.shortName = [schoolDic objectForKey:@"shortName"];
                NSArray *instituteList = [schoolDic objectForKey:@"instituteList"];
                if (instituteList && [instituteList count] > 0)
                {
                    if (schoolData.instituteMArray == nil)
                    {
                        schoolData.instituteMArray = [NSMutableArray array];
                    }
                    for (int nSubIndex = 0;nSubIndex < [instituteList count]; nSubIndex++)
                    {
                        NSDictionary *instituteDic = [instituteList objectAtIndex:nSubIndex];
                        InstituteData *instituteData = [[InstituteData alloc] init];
                        instituteData.instituteId = [instituteDic objectForKey:@"instituteId"];
                        instituteData.name = [instituteDic objectForKey:@"name"];
                        instituteData.shortName = [instituteDic objectForKey:@"shortName"];
                        [schoolData.instituteMArray addObject:instituteData];
                    }
                }
                [self.schoolMArray addObject:schoolData];
            }

        }
        
        return YES;
    }
    return NO;
}

@end
