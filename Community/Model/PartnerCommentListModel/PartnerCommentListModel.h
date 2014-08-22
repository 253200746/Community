//
//  PartnerCommentListModel.h
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface PartnerCommentData : NSObject
@property (nonatomic,strong) NSString *commentContent;
@property (nonatomic,strong) NSString *partnerCommenid;
@property (nonatomic,strong) NSString *partnerId;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userImg;
@property (nonatomic,strong) NSString *userName;
@end
@interface PartnerCommentListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
