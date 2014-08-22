//
//  ServerMethod.h
//  Community
//
//  Created by andy on 14-6-19.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#ifndef Community_ServerMethod_h
#define Community_ServerMethod_h


#define Server_BaseUrl @"http://www.shetuantong.com/myschool/"

//登录
#define Login_Method                        @"/service/user/login?"

//退出登录
#define LoginOut_Method                     @"/service/user/logout?"

//注册
#define Register_Method                     @"service/user/register?"

//获取验证码
#define GetVerifyCode_Method                @"/service/user/noteverify?"

//学校
#define SchollList_Method                   @"service/schoolList/query?"

//学院
#define InstituteList_Method                @"service/instituteList/query?"

//专业
#define MajorList_Method                    @"service/majorList/query?"

//区块类型
#define GetTypeList_Method                  @"/service/query_type?"

//消息列表
#define GetMessageList_Method               @""

//获取活动列表
#define GetActivityList_Method              @"/service/activityList/query?"

//获取咨询列表
#define Get_NewsList_Method                 @"/service/newsList/query?"

//获取组织列表
#define Get_OrganiztionList_Method          @"/service/associationList/query?"

//修改用户信息
#define Modify_UserInfo_Method              @"/service/user/modify_info?"

//获取求伴信息
#define Get_PartnerList_Method              @"/service/partnerList/query?"

//检查版本更新
#define CheckVersion_Method                 @"/sysAppVersionversionInterface?"

//获取学校详情
#define Get_SchoolDetail_Method             @"/service/schoolDetail/query?"

//获取学院详情
#define Get_InstituteDetail_Method          @"/service/instituteDetail/query?"

//获取主页详情
#define Get_MajorDetail_Method             @"/service/majorDetail/query?"

//获取组织详情
#define Get_AssociationDetail_Method        @"/service/associationDetail/query?"

//关注组织
#define AttendAssociation_Method            @"/service/association/attention_association?"

//活动详情
#define Get_ActivityDetail_Method           @"/service/activityDetail/query?"

//参加活动头像列表
#define Get_ActivityAttendList_Method       @"/service/activityAttendList/query?"

//申请感兴趣的活动
#define InterestedActivity_Method           @"/service/activity/interested_activity?"

//参加活动
#define AttendActivity_Method               @"/service/activity/attend_activity?"

//活动评论
#define Get_ActivityCommentList_Method      @"/service/comment/query"

//发表活动评论
#define Send_ActivityComment_Method         @"/service/comment/send_comment?"

//删除活动评论
#define Delete_ActivityComment_Method        @"/service/comment/delete_comment?"

//资讯详情
#define Get_NewsDetail_Method               @"/service/newsDetail/query?"

//资讯发表评论
#define Send_NewsComment_Mehtod             @"/service/newsComment/send_comment?"

//资讯评论删除
#define Delete_NewsComment_Method           @"/service/newsComment/delete_comment?"

//找回密码发送验证码
#define FindPassword_Method                 @"/service/user/find_password?"

//修改密码和重置密码
#define ModifyPassword_Method               @"/service/user/modify_password?"

//求伴详情接口
#define Partner_Detail_Method               @"/service/partnerDetail/query?"

//求伴的喜欢列表
#define Partner_LikeList_Method             @"/service/partnerLikeList/like_partner?"

//求伴查询评论列表
#define Partner_CommentList_Method          @"/service/partner_comment/query?"

//工具列表接口
#define Tool_List_Method                    @"/service/daoju?"

//意见反馈
#define FeedBack_Method                     @"/service/user/userReportProblemRequest?"
#endif
