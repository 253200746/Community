//
//  UserInfo.h
//  Community
//
//  Created by Andy on 14-6-20.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SchoolListModel.h"
#import "InstituteListModel.h"
#import "MajorListModel.h"

@interface UserInfo : NSObject
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userLoginName;
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *schoolName;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *enterSchoolYear;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *imQQ;
@property (nonatomic,strong) NSString *imWeiXin;
@property (nonatomic,strong) NSString *instituteId;
@property (nonatomic,strong) NSString *instituteName;
@property (nonatomic,strong) NSString *majorId;
@property (nonatomic,strong) NSString *majorName;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *shortMobile;
@property (nonatomic,strong) NSString *studentNumber;
@property (nonatomic,strong) NSString *headImgSrc;

@end
