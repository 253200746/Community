//
//  ActivityCommentListModel.h
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityComment : NSObject
@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *info;
@property (nonatomic,strong) NSString *userid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *times;
@end
@interface ActivityCommentListModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
