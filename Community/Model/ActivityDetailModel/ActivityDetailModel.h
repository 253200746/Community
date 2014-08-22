//
//  ActivityDetailModel.h
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityDetailModel : BaseModel
@property (nonatomic,strong) NSString *activityId;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *applyFinishTime;
@property (nonatomic,strong) NSString *applyStartTime;
@property (nonatomic,strong) NSString *associationId;
@property (nonatomic,strong) NSString *associationName;
@property (nonatomic,strong) NSString *attendNum;
@property (nonatomic,strong) NSString *clickRate;
@property (nonatomic,strong) NSString *commentNum;
@property (nonatomic,strong) NSString *detailInfo;
@property (nonatomic,strong) NSString *endtime;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *instituteId;
@property (nonatomic,strong) NSString *instituteName;
@property (nonatomic,strong) NSString *interestedNum;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *isAttend;
@property (nonatomic,strong) NSString *isInterested;
@property (nonatomic,strong) NSString *memberNum;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *organizer;
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *schoolName;
@property (nonatomic,strong) NSString *sponsor;
@property (nonatomic,strong) NSString *starttime;
@property (nonatomic,strong) NSString *systemtime;
@property (nonatomic,strong) NSString *type;

@end
