//
//  PartnerLikeListModel.h
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface PartnerLikeData : NSObject
@property (nonatomic,strong) NSString *imgurl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *partnerId;
@property (nonatomic,strong) NSString *times;
@property (nonatomic,strong) NSString *userid;
@end

@interface PartnerLikeListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
