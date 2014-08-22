//
//  ActivityCommentListModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityCommentListModel.h"

@implementation ActivityComment

@end

@implementation ActivityCommentListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_ActivityCommentList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        NSArray *commentList = [data objectForKey:@"commentList"];
        if (commentList && [commentList count])
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            [_dataMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [commentList count]; nIndex++)
            {
                NSDictionary *commentDic = [commentList objectAtIndex:nIndex];
                ActivityComment *activityComment = [[ActivityComment alloc] init];
                activityComment.commentId = [commentDic objectForKey:@"commentId"];
                activityComment.info = [commentDic objectForKey:@"info"];
                activityComment.userid = [commentDic objectForKey:@"userid"];
                activityComment.name = [commentDic objectForKey:@"name"];
                activityComment.userid = [commentDic objectForKey:@"imgUrl"];
                activityComment.name = [commentDic objectForKey:@"times"];
                [self.dataMArray addObject:activityComment];
            }
            
        }
        return YES;
    }
    return NO;
}
@end
