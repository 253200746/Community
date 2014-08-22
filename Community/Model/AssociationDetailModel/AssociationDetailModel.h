//
//  AssociationDetailModel.h
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface AssociationDetailModel : BaseModel
@property (nonatomic,strong) NSString *schoolName;
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *fansNum;
@property (nonatomic,strong) NSString *memberNum;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *associationName;
@property (nonatomic,strong) NSString *associationImgUrl;
@property (nonatomic,strong) NSString *associationId;
@property (nonatomic,strong) NSString *attention;
@end
