//
//  OrganizationModel.h
//  Community
//
//  Created by Andy on 14-7-13.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface OrganizationData : NSObject
@property (nonatomic,strong) NSString *associationId;
@property (nonatomic,strong) NSString *attention;
@property (nonatomic,strong) NSString *fansNum;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *memberNum;
@property (nonatomic,strong) NSString *name;
@end

@interface OrganizationModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
