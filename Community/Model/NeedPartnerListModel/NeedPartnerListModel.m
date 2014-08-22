//
//  NeedPartnerListModel.m
//  Community
//
//  Created by andy on 14-7-25.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//
#import "NeedPartnerListModel.h"
#import "CommentModel.h"

@implementation PartnerData
@end


@implementation NeedPartnerListModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_PartnerList_Method httpHeader:nil httpBody:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (data && [data count] > 0)
    {
        if (_dataMArray == nil)
        {
            _dataMArray = [NSMutableArray array];
        }
        [_dataMArray removeAllObjects];
        
        [_dataMArray removeAllObjects];
        NSArray *partnerArray = [data objectForKey:@"partnerList"];
        if (partnerArray && partnerArray)
        {
            for (int nIndex = 0; nIndex < [partnerArray count]; nIndex++)
            {
                NSDictionary *partnerDic = [partnerArray objectAtIndex:nIndex];
                if (partnerDic && [partnerDic count])
                {
                    PartnerData *partnerData = [[PartnerData alloc] init];
                    partnerData.clickRate = [partnerDic objectForKey:@"clickRate"];
                    partnerData.commentNum = [partnerDic objectForKey:@"commentNum"];
                    partnerData.content  = [partnerDic objectForKey:@"content"];
                    partnerData.imgurl = [partnerDic objectForKey:@"imgurl"];
                    partnerData.isStartTel = [partnerDic objectForKey:@"isStartTel"];
                    partnerData.likeNum = [partnerDic objectForKey:@"likeNum"];
                    partnerData.partnerId = [partnerDic objectForKey:@"partnerId"];
                    partnerData.telphone = [partnerDic objectForKey:@"telphone"];
                    partnerData.typeId = [partnerDic objectForKey:@"typeId"];
                    partnerData.typeName = [partnerDic objectForKey:@"typeName"];
                    partnerData.userId = [partnerDic objectForKey:@"userId"];
                    partnerData.userImgUrl = [partnerDic objectForKey:@"userImgUrl"];
                    partnerData.userName = [partnerDic objectForKey:@"userName"];
                    partnerData.youisLike = [partnerDic objectForKey:@"youisLike"];
                    NSArray *partnerCommentList3 = [partnerDic objectForKey:@"partnerCommentList3"];
                    if (partnerCommentList3 && [partnerCommentList3 count])
                    {
                        if (partnerData.partnerCommentList == nil)
                        {
                            partnerData.partnerCommentList = [NSMutableArray array];
                        }
                        [partnerData.partnerCommentList removeAllObjects];
                        for (int nSubIndex = 0; nSubIndex < [partnerCommentList3 count]; nSubIndex++)
                        {
                            NSDictionary *commentDic = [partnerCommentList3 objectAtIndex:nSubIndex];
                            CommentData *commentData = [[CommentData alloc] init];
                            commentData.commentContent = [commentDic objectForKey:@"commentContent"];
                            commentData.partnerCommenid = [commentDic objectForKey:@"partnerCommenid"];
                            commentData.partnerId = [commentDic objectForKey:@"partnerId"];
                            commentData.time = [commentDic objectForKey:@"time"];
                            commentData.userId = [commentDic objectForKey:@"userId"];
                            commentData.userImg = [commentDic objectForKey:@"userImg"];
                            commentData.userName = [commentDic objectForKey:@"userName"];
                            [partnerData.partnerCommentList addObject:commentData];
                        }
                    }
                    [self.dataMArray addObject:partnerData];
                }
            }
        }
        
        return YES;
    }
    return NO;
}
@end
