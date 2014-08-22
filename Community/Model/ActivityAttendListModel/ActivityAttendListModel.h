//
//  ActivityAttendListModel.h
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"
@interface AttendPerson : NSObject
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userImgUrl;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *nickName;
@end
@interface ActivityAttendListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
