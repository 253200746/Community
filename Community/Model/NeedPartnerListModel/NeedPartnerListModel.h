//
//  NeedPartnerListModel.h
//  Community
//
//  Created by andy on 14-7-25.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"



@interface PartnerData : NSObject

@property (nonatomic,strong) NSString *clickRate;
@property (nonatomic,strong) NSString *commentNum;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *imgurl;
@property (nonatomic,strong) NSString *isStartTel;
@property (nonatomic,strong) NSString *likeNum;
@property (nonatomic,strong) NSString *partnerId;
@property (nonatomic,strong) NSString *telphone;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *typeId;
@property (nonatomic,strong) NSString *typeName;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userImgUrl;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *youisLike;
@property (nonatomic,strong) NSMutableArray *partnerCommentList;
@end

@interface NeedPartnerListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
