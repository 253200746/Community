//
//  NewsDetailModel.h
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface NewsDetailModel : BaseModel
@property (nonatomic,strong) NSString *newsId;
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *schoolName;
@property (nonatomic,strong) NSString *infoName;
@property (nonatomic,strong) NSString *associationId;
@property (nonatomic,strong) NSString *associatioNname;
@property (nonatomic,strong) NSString *typeId;
@property (nonatomic,strong) NSString *typeName;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *systemtime;
@property (nonatomic,strong) NSString *commentNum;
@property (nonatomic,strong) NSString *clickRate;

@end
