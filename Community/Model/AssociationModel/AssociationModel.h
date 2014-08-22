//
//  AssociationModel.h
//  Community
//
//  Created by Andy on 14-7-9.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface AssociationData : NSObject
@property (nonatomic,strong) NSString *associationId;
@property (nonatomic,strong) NSString *associationName;
@end
@interface AssociationModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
