//
//  CommentModel.h
//  Community
//
//  Created by andy on 14-7-30.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface CommentData : NSObject
@property (nonatomic,strong) NSString *commentContent;
@property (nonatomic,strong) NSString *partnerCommenid;
@property (nonatomic,strong) NSString *partnerId;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userImg;
@property (nonatomic,strong) NSString *userName;
@end

@interface CommentModel : BaseModel

@end
