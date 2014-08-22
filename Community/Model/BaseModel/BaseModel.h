//
//  BaseModel.h
//  Community
//
//  Created by andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "HttpModel.h"
#import "ServerMethod.h"

@interface BaseModel : HttpModel

@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *resultCode;
@property (nonatomic,strong) NSString *errorMessage;
@property (nonatomic,strong) NSString *rootMessage;
@end
