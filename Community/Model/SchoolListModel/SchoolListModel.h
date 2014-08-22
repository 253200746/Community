//
//  SchoolListModel.h
//  Community
//
//  Created by Andy on 14-6-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface InstituteData : NSObject
@property (nonatomic,strong) NSString *instituteId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *shortName;
@end

@interface SchoolData : NSObject
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *logo;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *shortName;
@property (nonatomic,strong) NSMutableArray *instituteMArray;
@end

@interface SchoolListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *schoolMArray;
@end
