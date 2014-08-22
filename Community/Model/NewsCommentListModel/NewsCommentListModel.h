//
//  NewsCommentListModel.h
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface NewsComment : NSObject
@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *info;
@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSString *userid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *times;
@end

@interface NewsCommentListModel : BaseModel
@property (nonatomic,strong) NSString *systemtime;
@property (nonatomic,strong) NSString *commentNum;
@property (nonatomic,strong) NSMutableArray *commentMArray;
@end
