//
//  MajorListModel.h
//  Community
//
//  Created by Andy on 14-7-1.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface MajorData : NSObject
@property (nonatomic,strong) NSString *majorId;
@property (nonatomic,strong) NSString *name;
@end

@interface MajorListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *majorMArray;
@end
