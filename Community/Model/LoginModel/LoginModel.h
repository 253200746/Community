//
//  LoginModel.h
//  Community
//
//  Created by Andy on 14-7-4.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfo.h"
@interface LoginModel : BaseModel
@property (nonatomic,strong) UserInfo *userInfo;
@end
