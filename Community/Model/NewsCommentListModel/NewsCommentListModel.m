//
//  NewsCommentListModel.m
//  Community
//
//  Created by Andy on 14-8-2.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "NewsCommentListModel.h"

@implementation NewsComment

@end

@implementation NewsCommentListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_NewsDetail_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        self.systemtime = [data objectForKey:@"systemtime"];
        self.commentNum = [data objectForKey:@"commentNum"];
        NSArray *commentList = [data objectForKey:@"commentList"];
        if (commentList && [commentList count])
        {
            if (_commentMArray == nil)
            {
                _commentMArray = [NSMutableArray array];
            }
            [_commentMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [commentList count]; nIndex++)
            {
                NSDictionary *commentDic = [commentList objectAtIndex:nIndex];
                NewsComment *newsComment = [[NewsComment alloc] init];
                newsComment.commentId = [commentDic objectForKey:@"commentId"];
                newsComment.info = [commentDic objectForKey:@"info"];
                newsComment.userid = [commentDic objectForKey:@"commentId"];
                newsComment.name = [commentDic objectForKey:@"info"];
                newsComment.imgUrl = [commentDic objectForKey:@"commentId"];
                newsComment.times = [commentDic objectForKey:@"info"];
                [self.commentMArray addObject:newsComment];
            }
        }
        return YES;
    }
    return NO;
}
@end
