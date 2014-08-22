//
//  NewsModel.h
//  Community
//
//  Created by Andy on 14-7-7.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseModel.h"
#import "TypeModel.h"
#import "AssociationModel.h"

@interface NewsData : NSObject
@property (nonatomic,strong) NSString *associationId;
@property (nonatomic,strong) NSString *associationName;
@property (nonatomic,strong) NSString *campusId;
@property (nonatomic,strong) NSString *campusName;
@property (nonatomic,strong) NSString *clickRate;
@property (nonatomic,strong) NSString *commentNum;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *infoName;
@property (nonatomic,strong) NSString *isListisTop;
@property (nonatomic,strong) NSString *newsId;
@property (nonatomic,strong) NSString *systemtime;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) TypeData *type;
@end

@interface NewsModel : BaseModel
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end
