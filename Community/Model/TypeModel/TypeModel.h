//
//  TypeModel.h
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface TypeData : NSObject

@property (nonatomic,assign) NSInteger typeId;
@property (nonatomic,strong) NSString *typeName;

@end

@interface TypeModel : BaseModel
//typeMArray 存放TypeData数据
@property (nonatomic,strong) NSMutableArray *typeMArray;

@end
