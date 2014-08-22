//
//  PartnerCommentListModel.m
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerCommentListModel.h"

@implementation PartnerCommentData

@end

@implementation PartnerCommentListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Partner_CommentList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if ([self.resultCode isEqualToString:@"1"] && [data count] > 0)
    {
        NSArray *partnerCommentList = [data objectForKey:@"partnerCommentList"];
        if (partnerCommentList && [partnerCommentList count])
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            [_dataMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [partnerCommentList count]; nIndex++)
            {
                NSDictionary *commentDic = [partnerCommentList objectAtIndex:nIndex];
                if (commentDic && [commentDic count])
                {
                    PartnerCommentData *commentData = [[PartnerCommentData alloc] init];
                    commentData.commentContent = [commentDic objectForKey:@"commentContent"];
                    commentData.partnerCommenid = [commentDic objectForKey:@"partnerCommenid"];
                    commentData.partnerId = [commentDic objectForKey:@"partnerId"];
                    commentData.time = [commentDic objectForKey:@"time"];
                    commentData.userId = [commentDic objectForKey:@"userId"];
                    commentData.userImg = [commentDic objectForKey:@"userImg"];
                    commentData.userName = [commentDic objectForKey:@"userName"];
                    [self.dataMArray addObject:commentData];
                }
            }
            
        }
        return YES;
    }
    return NO;
}
@end
