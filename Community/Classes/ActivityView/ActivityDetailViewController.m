//
//  ActivityDetailViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "EWPIconLable.h"
#import "ActivityDetailModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "UIImageView+WebCache.h"
#import "ActivityAttendListModel.h"
#import "InterestedActivityModel.h"
#import "AttendActivityModel.h"
#import "SendActivityCommentModel.h"
#import "LoginViewController.h"
#import "ApplyActivityInfoViewController.h"

@interface ActivityDetailViewController ()<UIWebViewDelegate,UITextFieldDelegate,BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *attendMArray;
@property (nonatomic,strong) UIView *activityBaseView;
@property (nonatomic,strong) UIWebView *activityContentView;

@property (nonatomic,strong) UILabel *activityTitleLable;
@property (nonatomic,strong) UIImageView *activityLogo;
@property (nonatomic,strong) UILabel *applyTimeLable;
@property (nonatomic,strong) UILabel *startTimeLable;
@property (nonatomic,strong) UILabel *endTimeLable;
@property (nonatomic,strong) UILabel *placeLable;
@property (nonatomic,strong) UILabel *typeLable;//类型
@property (nonatomic,strong) UILabel *sponsorLable;//主办方
@property (nonatomic,strong) UILabel *organizerLable;//承办方
@property (nonatomic,strong) UIScrollView *applyInfoView;//报名信息
@property (nonatomic,strong) UILabel *applyNumber;
@property (nonatomic,strong) EWPButton *interestBtn;
@property (nonatomic,strong) EWPButton *attendBtn;
@property (nonatomic,strong) UITextField *commentField;
@property (nonatomic,strong) UIView *commentTextFieldBKView;
@property (nonatomic,strong) BaseTableCanvas *commentList;
@property (nonatomic,strong) ActivityDetailModel *activityDetailModel;
@end

@implementation ActivityDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseCanvasType = kbaseScroolViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"活动详情";
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - 44);
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    int nYOffset = 0;
    //活动时间地点详细信息
    _activityBaseView = [[UIView alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 180)];
    _activityBaseView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_activityBaseView];
    nYOffset += 180;
    
    int nYSubOffset = 0;
    int nXSubOffset = 90;
    //活动标题
    _activityTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, nYSubOffset, _activityBaseView.frame.size.width, 30)];
    _activityTitleLable.font = [UIFont boldSystemFontOfSize:15.0f];
    _activityTitleLable.text = @"2014莫文蔚杭州演唱会";
    [_activityBaseView addSubview:_activityTitleLable];
    nYSubOffset += 30;
    
    //活动logo
    _activityLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYSubOffset, 80, 120)];
    [_activityBaseView addSubview:_activityLogo];
    
    //报名时间
    EWPIconLable *iconTitle = [[EWPIconLable alloc] initWithFrame:CGRectMake(nXSubOffset, nYSubOffset, 70, 15) icon:[UIImage imageNamed:@"time"] title:@"报名时间:"];
    iconTitle.textSize = 12.0f;
    iconTitle.textXOffset = 2.0f;
    [_activityBaseView addSubview:iconTitle];
    
    _applyTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(nXSubOffset + iconTitle.frame.size.width, nYSubOffset, 120, 15)];
    _applyTimeLable.font = [UIFont systemFontOfSize:12.0f];
    _applyTimeLable.text = @"2月8日-2月13日";
    [_activityBaseView addSubview:_applyTimeLable];
    nYSubOffset += 18;
    
    //开始时间
    iconTitle = [[EWPIconLable alloc] initWithFrame:CGRectMake(nXSubOffset, nYSubOffset, 70, 15) icon:[UIImage imageNamed:@"time"] title:@"开始时间:"];
    iconTitle.textSize = 12.0f;
    iconTitle.textXOffset = 2.0f;
    [_activityBaseView addSubview:iconTitle];
    
    _startTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(nXSubOffset + iconTitle.frame.size.width, nYSubOffset, 120, 15)];
    _startTimeLable.font = [UIFont systemFontOfSize:12.0f];
    _startTimeLable.text = @"2月8日下午6时30分";
    [_activityBaseView addSubview:_startTimeLable];
    nYSubOffset += 18;
    
    //结束时间
    iconTitle = [[EWPIconLable alloc] initWithFrame:CGRectMake(nXSubOffset, nYSubOffset, 70, 15) icon:[UIImage imageNamed:@"time"] title:@"结束时间:"];
    iconTitle.textSize = 12.0f;
    iconTitle.textXOffset = 2.0f;
    [_activityBaseView addSubview:iconTitle];
    
    _endTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(nXSubOffset + iconTitle.frame.size.width, nYSubOffset, 120, 15)];
    _endTimeLable.font = [UIFont systemFontOfSize:12.0f];
    _endTimeLable.text = @"2月8日下午9时30分";
    [_activityBaseView addSubview:_endTimeLable];
    nYSubOffset += 18;
    
    //地点
    iconTitle = [[EWPIconLable alloc] initWithFrame:CGRectMake(nXSubOffset, nYSubOffset, 50, 15) icon:[UIImage imageNamed:@"place"] title:@"地点:"];
    iconTitle.textSize = 12.0f;
    iconTitle.textXOffset = 2.0f;
    [_activityBaseView addSubview:iconTitle];
    
    _placeLable = [[UILabel alloc] initWithFrame:CGRectMake(nXSubOffset + iconTitle.frame.size.width, nYSubOffset, 120, 15)];
    _placeLable.font = [UIFont systemFontOfSize:12.0f];
    _placeLable.text = @"地球村亚洲中国杭州";
    [_activityBaseView addSubview:_placeLable];
    nYSubOffset += 18;
    
    //类型
    iconTitle = [[EWPIconLable alloc] initWithFrame:CGRectMake(nXSubOffset, nYSubOffset, 50, 15) icon:[UIImage imageNamed:@"type"] title:@"类型:"];
    iconTitle.textSize = 12.0f;
    iconTitle.textXOffset = 2.0f;
    [_activityBaseView addSubview:iconTitle];
    
    _typeLable = [[UILabel alloc] initWithFrame:CGRectMake(nXSubOffset + iconTitle.frame.size.width, nYSubOffset, 120, 15)];
    _typeLable.font = [UIFont systemFontOfSize:12.0f];
    _typeLable.text = @"娱乐";
    [_activityBaseView addSubview:_typeLable];
    nYSubOffset += 18;
    
    //主办方
    iconTitle = [[EWPIconLable alloc] initWithFrame:CGRectMake(nXSubOffset, nYSubOffset, 50, 15) icon:[UIImage imageNamed:@"persong"] title:@"主办方:"];
    iconTitle.textSize = 12.0f;
    iconTitle.textXOffset = 2.0f;
    [_activityBaseView addSubview:iconTitle];
    
    _sponsorLable = [[UILabel alloc] initWithFrame:CGRectMake(nXSubOffset + iconTitle.frame.size.width, nYSubOffset, 120, 15)];
    _sponsorLable.font = [UIFont systemFontOfSize:12.0f];
    _sponsorLable.text = @"浙江大学";
    [_activityBaseView addSubview:_sponsorLable];
    nYSubOffset += 18;
    
    //承办方
    iconTitle = [[EWPIconLable alloc] initWithFrame:CGRectMake(nXSubOffset, nYSubOffset, 50, 15) icon:[UIImage imageNamed:@"persong"] title:@"承办方:"];
    iconTitle.textSize = 12.0f;
    iconTitle.textXOffset = 2.0f;
    [_activityBaseView addSubview:iconTitle];
    
    _organizerLable = [[UILabel alloc] initWithFrame:CGRectMake(nXSubOffset + iconTitle.frame.size.width, nYSubOffset, 120, 15)];
    _organizerLable.font = [UIFont systemFontOfSize:12.0f];
    _organizerLable.text = @"浙江大学";
    [_activityBaseView addSubview:_organizerLable];
    nYSubOffset += 18;
    
    _interestBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _interestBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_interestBtn setTitle:@"感兴趣" forState:UIControlStateNormal];
    [_interestBtn setBackgroundColor:[UIColor greenColor]];
    [_interestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _interestBtn.frame = CGRectMake(nXSubOffset, nYSubOffset, 50, 20);
    [_activityBaseView addSubview:_interestBtn];
    __weak typeof(self) weakSelf = self;
    _interestBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if ([AppInfo shareAppInfoManager].bLoginSuccess)
        {
            UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
            InterestedActivityModel *model = [[InterestedActivityModel alloc] init];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:strongSelf.activityId forKey:@"activityId"];
            [params setObject:userInfo.userId forKey:@"userId"];
            if (strongSelf.activityDetailModel.isInterested && [strongSelf.activityDetailModel.isInterested length])
            {
                if ([strongSelf.activityDetailModel.isInterested isEqualToString:@"yes"])
                {
                    [params setObject:@"no" forKey:@"isInterested"];
                }
                else
                {
                    [params setObject:@"yes" forKey:@"isInterested"];
                }
            }
            
            [model requestDataWithParams:params success:^(id object)
            {
                if ([model.resultCode isEqualToString:@"1"])
                {
                    strongSelf.activityDetailModel.isInterested = @"yes";
                    [strongSelf.interestBtn setTitle:@"取消感兴趣" forState:UIControlStateNormal];
                }
                else if ([model.resultCode isEqualToString:@"3"])
                {
                    strongSelf.activityDetailModel.isInterested = @"no";
                    [strongSelf.interestBtn setTitle:@"感兴趣" forState:UIControlStateNormal];
                }
                [strongSelf showAlertView:nil message:model.message confirm:nil cancel:nil];
            } fail:^(id object) {
                
            }];
        }
    };
    
    _attendBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _attendBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_attendBtn setTitle:@"参加" forState:UIControlStateNormal];
    [_attendBtn setBackgroundColor:[UIColor greenColor]];
    [_attendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _attendBtn.frame = CGRectMake(nXSubOffset + 60, nYSubOffset, 50, 20);
    [_activityBaseView addSubview:_attendBtn];
    _attendBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if ([AppInfo shareAppInfoManager].bLoginSuccess)
        {
            UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
            AttendActivityModel *model = [[AttendActivityModel alloc] init];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:strongSelf.activityId forKey:@"activityId"];
            [params setObject:userInfo.userId forKey:@"userId"];
            if (strongSelf.activityDetailModel.isInterested && [strongSelf.activityDetailModel.isInterested length])
            {
                if ([strongSelf.activityDetailModel.isAttend isEqualToString:@"yes"])
                {
                    [params setObject:@"no" forKey:@"isAttend"];
                }
                else
                {
                    [params setObject:@"yes" forKey:@"isAttend"];
                }
            }
            
            [model requestDataWithParams:params success:^(id object)
             {
                 if ([model.resultCode isEqualToString:@"1"])
                 {
                    strongSelf.activityDetailModel.isAttend = @"yes";
                    [strongSelf.attendBtn setTitle:@"取消参加" forState:UIControlStateNormal];
                 }
                 else if ([model.resultCode isEqualToString:@"3"])
                 {
                    strongSelf.activityDetailModel.isAttend = @"no";
                    [strongSelf.attendBtn setTitle:@"参加" forState:UIControlStateNormal];
                 }
                 
                [strongSelf showAlertView:nil message:model.message confirm:nil cancel:nil];
                 
             } fail:^(id object) {
                 
             }];
        }
    };
    
    //活动介绍标题
    UILabel *activityInfoTiltle = [[UILabel alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 20)];
    activityInfoTiltle.font = [UIFont systemFontOfSize:14.0f];
    activityInfoTiltle.text = @"活动介绍";
    [self.scrollView addSubview:activityInfoTiltle];
    nYOffset += 20;
    
    //活动介绍内容
    _activityContentView = [[UIWebView alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 200)];
    _activityContentView.backgroundColor = [UIColor clearColor];
    [_activityContentView setUserInteractionEnabled:NO];
    _activityContentView.delegate = self;
    UIScrollView *webScroolView = (UIScrollView *)[[_activityContentView subviews] objectAtIndex:0];
    webScroolView.bounces = NO;
    webScroolView.backgroundColor = [UIColor clearColor];
    [_activityContentView setScalesPageToFit:NO];
    [self.scrollView addSubview:_activityContentView];
    nYOffset += 200;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, nYOffset);
    
    UILabel *applyTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, nYOffset, 80, 20)];
    applyTitle.text = @"报名信息";
    [self.scrollView addSubview:applyTitle];
    nYOffset += 20;
    
    _applyNumber = [[UILabel alloc] initWithFrame:CGRectMake(90, nYOffset, 100, 20)];
    _applyNumber.textColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:_applyNumber];
    
    _applyInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 70)];
    [self.scrollView addSubview:_applyInfoView];
    nYOffset += 70;
    nYOffset += 10;
    
    _commentList = [[BaseTableCanvas alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 0) style:UITableViewStylePlain];
    _commentList.baseDataSource = self;
    _commentList.baseDelegate = self;
    [self.scrollView addSubview:_commentList];
    
    _commentTextFieldBKView = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 44 - 44, 300, 44)];
    _commentTextFieldBKView.backgroundColor = [CommonFuction colorFromHexRGB:@"F7F7F7"];
    [self.view addSubview:_commentTextFieldBKView];
    
    _commentField = [[UITextField alloc] initWithFrame:CGRectMake(0, 7, 300, 30)];
    _commentField.placeholder = @"写评论";
    _commentField.delegate = self;
    _commentField.layer.cornerRadius = 5.0f;
    _commentField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _commentField.layer.borderWidth = 1;
    _commentField.returnKeyType = UIReturnKeySend;
    [_commentTextFieldBKView addSubview:_commentField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
    [self setNavigationBarRightItem:@"分享" itemNormalImg:nil itemHighlightImg:nil withBlock:^(id sender) {
        
    }];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(notifyShowKeyBoard:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(notifyHideKeyBoard:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
    [self getData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = YES;
}

/*当键盘快要显示时调用*/
- (void)notifyShowKeyBoard: (NSNotification*)note
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.1];
    CGRect rect = self.commentTextFieldBKView.frame;
    rect.origin.y -= 108;
    self.commentTextFieldBKView.frame = rect;
    [UIView commitAnimations];
    
}

/*当键盘快要消失时调用*/
- (void)notifyHideKeyBoard: (NSNotification*)note
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.1];
    CGRect rect = self.commentTextFieldBKView.frame;
    rect.origin.y += 108;
    self.commentTextFieldBKView.frame = rect;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSString class]])
    {
        self.activityId = argumentData;
    }
}
- (void)getData
{
    if (self.activityId && [self.activityId length])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.activityId forKey:@"activityId"];
        if ([AppInfo shareAppInfoManager].bLoginSuccess)
        {
            [params setObject:[UserInfoManager shareUserInfoManager].userInfo.userId forKey:@"userId"];
        }
    
        __weak typeof(self) weakSelf = self;
        [self requestDataWithAnalyseModel:[ActivityDetailModel class] params:params success:^(id object) {
            __strong typeof(self) strong = weakSelf;
            strong.activityDetailModel = (ActivityDetailModel *)object;
            if ([strong.activityDetailModel.resultCode isEqualToString:@"1"])
            {
                [strong performSelectorOnMainThread:@selector(showDetaiInfo:) withObject:strong.activityDetailModel waitUntilDone:NO];
            }
        } fail:^(id object) {
            
        }];
    }
    
    ActivityAttendListModel *model = [[ActivityAttendListModel alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.activityId forKey:@"activityId"];
    [params setObject:@"0" forKey:@"lastNo"];
    [params setObject:@"1000" forKey:@"pageSize"];
    [model requestDataWithParams:params success:^(id object) {
        if (_attendMArray == nil)
        {
            _attendMArray = [NSMutableArray array];
        }
        [_attendMArray removeAllObjects];
        [self.attendMArray addObjectsFromArray:model.dataMArray];
        [self performSelector:@selector(showAttendPerson) withObject:nil];
    } fail:^(id object) {
        
    }];
}

- (void)showAttendPerson
{
    if (self.attendMArray && [self.attendMArray count])
    {
        int nDispalyCount =  [self.attendMArray count] > 6? 6 : [self.attendMArray count];
        for (int nIndex = 0; nIndex < nDispalyCount; nIndex++)
        {
            AttendPerson *person = [self.attendMArray objectAtIndex:nIndex];
            int nWidth = 40;
            int nHeight = 40;
            int nSpace = 5;
            int xPos = nSpace + (nWidth + nSpace) * nIndex;
            UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, nSpace, nWidth, nHeight)];
            [headImg setImageWithURL:[NSURL URLWithString:person.userImgUrl] placeholderImage:nil];
            [self.applyInfoView addSubview:headImg];
            
            CGSize size = [CommonFuction sizeOfString:person.nickName withFontSize:11.0f];
            if (size.width > 40)
            {
                size.width = 40;
            }
            UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(xPos +(nWidth - size.width)/2, 50, size.width, 20)];
            userName.font = [UIFont systemFontOfSize:11.0f];
            userName.textColor = [UIColor blackColor];
            userName.text = person.nickName;
            [self.applyInfoView addSubview:userName];
        }
        EWPButton *morePersonBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
        [morePersonBtn setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
        morePersonBtn.frame = CGRectMake(5 + 45 * 6, 5, 30, 60);
        [self.applyInfoView addSubview:morePersonBtn];
        [self.applyInfoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showApplyActivityInfo)]];
    }
}

- (void)showDetaiInfo:(ActivityDetailModel *)model
{
    NSString *applyStarTime = [model.applyStartTime substringWithRange:NSMakeRange(5, 5)];
    NSString *applyFinishTime = [model.applyFinishTime substringWithRange:NSMakeRange(5, 5)];
    self.applyTimeLable.text = [NSString stringWithFormat:@"%@ - %@",applyStarTime,applyFinishTime];
    self.startTimeLable.text = [model.starttime substringToIndex:([model.starttime length] - 3)];
    self.endTimeLable.text = [model.endtime substringToIndex:([model.endtime length] - 3)];
    self.placeLable.text = model.address;
    self.typeLable.text = model.type;
    self.sponsorLable.text = model.sponsor;
    self.organizerLable.text = model.organizer;
    [self.activityLogo setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];

    if (self.activityDetailModel && self.activityDetailModel.isInterested)
    {
        if ([self.activityDetailModel.isInterested isEqualToString:@"yes"])
        {
            [self.interestBtn setTitle:@"取消感兴趣" forState:UIControlStateNormal];
        }
        else
        {
            [self.interestBtn setTitle:@"感兴趣" forState:UIControlStateNormal];
        }
    }
    else
    {
        [self.interestBtn setTitle:@"感兴趣" forState:UIControlStateNormal];
    }
    
    if (self.activityDetailModel && self.activityDetailModel.isAttend)
    {
        if ([self.activityDetailModel.isAttend isEqualToString:@"yes"])
        {
            [self.attendBtn setTitle:@"取消参加" forState:UIControlStateNormal];
        }
        else
        {
            [self.attendBtn setTitle:@"参加" forState:UIControlStateNormal];
        }
    }
    else
    {
        [self.attendBtn setTitle:@"参加" forState:UIControlStateNormal];
    }
    [self.activityContentView loadHTMLString:model.detailInfo baseURL:nil];
    
}

- (void)showApplyActivityInfo
{
    [self pushCanvas:NSStringFromClass([ApplyActivityInfoViewController class]) withArgument:self.attendMArray];
}

#pragma mark - UIWebViewDelegate


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=300;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
//1.方法一
//    CGFloat webViewHeight=[webView.scrollView contentSize].height;
//    CGRect newFrame = webView.frame;
//    newFrame.size.height = webViewHeight;
//    webView.frame = newFrame;
 
    //2.方法二
//    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
//    CGRect newFrame = webView.frame;
//    newFrame.size.height = actualSize.height;
//    webView.frame = newFrame;
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    height += 10;
    CGRect rect = webView.frame;
    rect.size.height = height;
    webView.frame = rect;
    
    CGRect atten
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);

    CGSize size = self.scrollView.contentSize;
    size.height += height;
    size.height -= 150;
    self.scrollView.contentSize = size;

}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_commentField resignFirstResponder];
    if (![AppInfo shareAppInfoManager].bLoginSuccess)
    {
        [self pushCanvas:NSStringFromClass([LoginViewController class]) withArgument:nil];
        return YES;
    }
    
    if ([_commentField.text length] == 0)
    {
        [self showAlertView:nil message:@"请输入评论内容" confirm:nil cancel:nil];
        return YES;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.activityId forKey:@"activityId"];
    [params setObject:[UserInfoManager shareUserInfoManager].userInfo.userId forKey:@"userId"];
    [params setObject:_commentField.text forKey:@"info"];
    [self requestDataWithAnalyseModel:[SendActivityCommentModel class] params:params success:^(id object) {
        SendActivityCommentModel *model = (SendActivityCommentModel *)object;
        if ([model.resultCode isEqualToString:@"1"])
        {
            self.commentField.text = @"";
            [self showAlertView:nil message:model.message confirm:nil cancel:nil];
        }
    } fail:^(id object) {
        
    }];
    return YES;
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    UITableViewCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

@end
