//
//  LoginModel.m
//  Community
//
//  Created by Andy on 14-7-4.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "LoginModel.h"


@implementation LoginModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Login_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] &&  data && [data count] > 0)
    {
        _userInfo = [[UserInfo alloc] init];
        _userInfo.userId = [data objectForKey:@"userId"];
        _userInfo.userLoginName = [data objectForKey:@"userLoginName"];
        _userInfo.schoolId = [data objectForKey:@"schoolId"];
        _userInfo.schoolName = [data objectForKey:@"schoolName"];
        _userInfo.email = [data objectForKey:@"email"];
        _userInfo.enterSchoolYear = [data objectForKey:@"enterSchoolYear"];
        _userInfo.gender = [data objectForKey:@"gender"];
        _userInfo.imQQ = [data objectForKey:@"imQQ"];
        _userInfo.imWeiXin = [data objectForKey:@"imWeiXin"];
        _userInfo.instituteId = [data objectForKey:@"instituteId"];
        _userInfo.instituteName = [data objectForKey:@"instituteName"];
        _userInfo.majorId = [data objectForKey:@"majorId"];
        _userInfo.majorName = [data objectForKey:@"majorName"];
        _userInfo.mobile = [data objectForKey:@"mobile"];
        _userInfo.name = [data objectForKey:@"name"];
        _userInfo.nickName = [data objectForKey:@"nickName"];
        _userInfo.shortMobile = [data objectForKey:@"shortMobile"];
        _userInfo.studentNumber = [data objectForKey:@"studentNumber"];
        _userInfo.headImgSrc = [data objectForKey:@"headImgSrc"];
        
        return YES;
    }
    return NO;
}

@end
