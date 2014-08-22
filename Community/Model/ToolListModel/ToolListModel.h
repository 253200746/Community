//
//  ToolListModel.h
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface ToolData : NSObject
@property (nonatomic,strong) NSString *argument;
@property (nonatomic,strong) NSString *argumentnumber;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *url;
@end

@interface ToolListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
