//
//  SchoolDetailModel.h
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface SchoolDetailModel : BaseModel
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *schooName;
@property (nonatomic,strong) NSString *schoolShortName;
@property (nonatomic,strong) NSString *leader;
@property (nonatomic,strong) NSString *descInfo;
@property (nonatomic,strong) NSString *schoolAddr;
@property (nonatomic,strong) NSString *zipcode;
@property (nonatomic,strong) NSString *provinceId;
@property (nonatomic,strong) NSString *provinceName;
@property (nonatomic,strong) NSString *cityId;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *areaId;
@property (nonatomic,strong) NSString *areaName;
@property (nonatomic,strong) NSString *headcount;
@property (nonatomic,strong) NSString *logoUrl;
@end
