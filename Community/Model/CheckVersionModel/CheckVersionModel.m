//
//  CheckVersionModel.m
//  Community
//
//  Created by andy on 14-7-30.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "CheckVersionModel.h"

@implementation CheckVersionModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:CheckVersion_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.softName = [data objectForKey:@"softName"];
        self.versionNo = [data objectForKey:@"versionNo"];
        self.forceUpdate = [data objectForKey:@"forceUpdate"];
        self.forceUpdateVersion = [data objectForKey:@"forceUpdateVersion"];
        self.updateBy = [data objectForKey:@"updateBy"];
        self.updateTime = [data objectForKey:@"updateTime"];
        self.updateDesc = [data objectForKey:@"updateDesc"];
        self.downUrl = [data objectForKey:@"downUrl"];
        return YES;
    }
    return NO;
}

@end
