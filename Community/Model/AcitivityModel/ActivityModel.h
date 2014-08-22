//
//  ActivityModel.h
//  Community
//
//  Created by Andy on 14-6-19.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityData : NSObject
@property (nonatomic,strong) NSString *activityId;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *attendNum;
@property (nonatomic,strong) NSString *begindays;
@property (nonatomic,strong) NSString *applyFinishTime;
@property (nonatomic,strong) NSString *applyStartTime;
@property (nonatomic,strong) NSString *clickRate;
@property (nonatomic,strong) NSString *commentNum;
@property (nonatomic,strong) NSString *detailInfo;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *interestedNum;
@property (nonatomic,strong) NSString *isListisTop;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sponsor;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *systemtime;
@property (nonatomic,strong) NSString *type;
@end

@interface ActivityModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
