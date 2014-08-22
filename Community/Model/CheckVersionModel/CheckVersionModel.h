//
//  CheckVersionModel.h
//  Community
//
//  Created by andy on 14-7-30.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface CheckVersionModel : BaseModel
@property (nonatomic,strong) NSString *updateDesc;
@property (nonatomic,strong) NSString *updateBy;
@property (nonatomic,strong) NSString *softName;
@property (nonatomic,strong) NSString *updateTime;
@property (nonatomic,strong) NSString *versionNo;
@property (nonatomic,strong) NSString *forceUpdate;
@property (nonatomic,strong) NSString *downUrl;
@property (nonatomic,strong) NSString *forceUpdateVersion;
@end
