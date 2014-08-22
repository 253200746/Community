 //
//  PersonInfoViewController.m
//  Community
//
//  Created by Andy on 14-6-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "EWPDialog.h"
#import "LoginOutModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "UIButton+WebCache.h"
#import "SchooListViewController.h"
#import "InstituteListViewController.h"
#import "MajorListViewController.h"
#import "ModifyUserInfoModel.h"

@interface PersonInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) EWPButton *headBtn;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) EWPButton *schoolBtn;
@property (nonatomic,strong) EWPButton *instituteBtn;
@property (nonatomic,strong) EWPButton *majorBtn;
@property (nonatomic,strong) EWPButton *startYearBtn;
@property (nonatomic,strong) UITextField *studentNumber;
@property (nonatomic,strong) UITextField *longMobile;
@property (nonatomic,strong) UITextField *shortMobile;
@property (nonatomic,strong) EWPButton *sexBtn;
@property (nonatomic,strong) UITextField *email;

@property (nonatomic,assign) BOOL editState;
@property (nonatomic,strong) UITableView *sexView;

@property (nonatomic,strong) UserInfo *userInfo;
@end

@implementation PersonInfoViewController

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
    self.title = @"个人信息";
    self.editState = NO;
    
    self.userInfo = [UserInfoManager shareUserInfoManager].userInfo;
    
    self.scrollView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 44);
    
    int nTitleXOffset = 20;
    int nContentXOffset = 100;
    int nArrowXOffset = 280;
    
    //第一section
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view1];
    
    int nYOffset1 = 0;
    //头像
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset1, view1.frame.size.width, 100)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 40, 80, 20)];
    title.text = @"头像";
    [itemView addSubview:title];
    
    _headBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame = CGRectMake(nContentXOffset, 10, 80, 80);
    [_headBtn setImageWithURL:[NSURL URLWithString:_userInfo.headImgSrc] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"headerdefault"]];
    [_headBtn addTarget:self action:@selector(OnSelectHead:) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:_headBtn];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 40, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnSelectHead:)]];
    [view1 addSubview:itemView];
    nYOffset1 += 100;
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset1, view1.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view1 addSubview:lineImg];
    
    //用户名
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset1, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"用户名";
    [itemView addSubview:title];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(nContentXOffset, 15, 250, 20)];
    _userName.text = _userInfo.userLoginName;
    [itemView addSubview:_userName];
    
    [view1 addSubview:itemView];
    nYOffset1 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset1, view1.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view1 addSubview:lineImg];
    
    //真实姓名
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset1, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"真实姓名";
    [itemView addSubview:title];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(nContentXOffset, 15, 250, 20)];
    _name.text = _userInfo.name;
    [itemView addSubview:_name];
    
    [view1 addSubview:itemView];
    
    //第二section
    int nYOffset2 = 0;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 220, 300, 450)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view2];
    
    //学校
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"学校";
    [itemView addSubview:title];
    
    _schoolBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [_schoolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _schoolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _schoolBtn.frame = CGRectMake(nContentXOffset, 15, 200, 20);
    if (_userInfo.schoolName && [_userInfo.schoolName length])
    {
       [_schoolBtn setTitle:_userInfo.schoolName forState:UIControlStateNormal];
    }
    else
    {
       [_schoolBtn setTitle:@"请选择学校" forState:UIControlStateNormal];
    }
    [_schoolBtn addTarget:self action:@selector(OnSelectSchool:) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:_schoolBtn];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];
    
    //分院
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"分院";
    [itemView addSubview:title];
    
    _instituteBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [_instituteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _instituteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _instituteBtn.frame = CGRectMake(nContentXOffset, 15, 200, 20);
    if (_userInfo.instituteName && [_userInfo.instituteName length])
    {
        [_instituteBtn setTitle:_userInfo.instituteName forState:UIControlStateNormal];
    }
    else
    {
        [_instituteBtn setTitle:@"请选择分院" forState:UIControlStateNormal];
    }
    [_instituteBtn addTarget:self action:@selector(OnSelectInstitute:) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:_instituteBtn];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];

    //专业
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"专业";
    [itemView addSubview:title];
    
    _majorBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [_majorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _majorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _majorBtn.frame = CGRectMake(nContentXOffset, 15, 200, 20);
    if (_userInfo.majorName && [_userInfo.majorName length])
    {
        [_majorBtn setTitle:_userInfo.majorName forState:UIControlStateNormal];
    }
    else
    {
        [_majorBtn setTitle:@"请选择专业" forState:UIControlStateNormal];
    }
    [_majorBtn addTarget:self action:@selector(OnSelectMajor:) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:_majorBtn];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;

    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];
    
    //入学年份
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"入学年份";
    [itemView addSubview:title];
    
    _startYearBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [_startYearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _startYearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _startYearBtn.frame = CGRectMake(nContentXOffset, 15, 200, 20);
    if (_userInfo.enterSchoolYear && [_userInfo.enterSchoolYear length])
    {
        [_startYearBtn setTitle:_userInfo.enterSchoolYear forState:UIControlStateNormal];
    }
    else
    {
        [_startYearBtn setTitle:@"请输入入学年份" forState:UIControlStateNormal];
    }
    
    [itemView addSubview:_startYearBtn];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];

    //学号
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"学号";
    [itemView addSubview:title];
    
    _studentNumber = [[UITextField alloc] initWithFrame:CGRectMake(nContentXOffset, 15, 200, 20)];
    _studentNumber.delegate = self;
    if (_userInfo.studentNumber && [_userInfo.studentNumber length])
    {
       _studentNumber.text = _userInfo.studentNumber;
    }
    else
    {
        _studentNumber.placeholder = @"请输入学号";
    }
    
    [itemView addSubview:_studentNumber];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];
    
    //手机长号
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"手机长号";
    [itemView addSubview:title];
    
    _longMobile = [[UITextField alloc] initWithFrame:CGRectMake(nContentXOffset, 15, 200, 20)];
    _longMobile.delegate = self;
    if (_userInfo.mobile)
    {
        _longMobile.text = _userInfo.mobile;
    }
    else
    {
        _longMobile.placeholder = @"请输入手机号";
    }
    
    [itemView addSubview:_longMobile];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];
    
    //手机短号
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"手机短号";
    [itemView addSubview:title];
    
    _shortMobile = [[UITextField alloc] initWithFrame:CGRectMake(nContentXOffset, 15, 200, 20)];
    _shortMobile.delegate = self;
    if (_userInfo.shortMobile && [_userInfo.shortMobile length])
    {
        _shortMobile.text = _userInfo.shortMobile;
    }
    else
    {
        _shortMobile.placeholder = @"请输入短号";
    }
    
    [itemView addSubview:_shortMobile];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];
    
    //性别
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"性别";
    [itemView addSubview:title];
    
    _sexBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [_sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sexBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sexBtn.frame = CGRectMake(nContentXOffset, 15, 200, 20);
    if ([_userInfo.gender isEqualToString:@"1"])
    {
        [_sexBtn setTitle:@"男" forState:UIControlStateNormal];
    }
    else
    {
        [_sexBtn setTitle:@"女" forState:UIControlStateNormal];
    }
    
    [_sexBtn addTarget:self action:@selector(showSexDialog) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:_sexBtn];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];

    //邮箱
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset2, view1.frame.size.width, 50)];
    title = [[UILabel alloc] initWithFrame:CGRectMake(nTitleXOffset, 15, 80, 20)];
    title.text = @"邮箱";
    [itemView addSubview:title];
    
     _email= [[UITextField alloc] initWithFrame:CGRectMake(nContentXOffset, 15, 200, 20)];
    _email.delegate = self;
    if (_userInfo.email && [_userInfo.email length])
    {
        _email.text = _userInfo.email;
    }
    else
    {
        _email.placeholder = @"请输入邮箱";
    }
    
    [itemView addSubview:_email];
    
    arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(nArrowXOffset, 15, 12, 20)];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [itemView addSubview:arrowImg];
    
    [view2 addSubview:itemView];
    nYOffset2 += 50;
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset2, view2.frame.size.width, 1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [view2 addSubview:lineImg];

    
    EWPButton *exitBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(20, 700, 280, 40);
    exitBtn.backgroundColor = [UIColor greenColor];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.scrollView addSubview:exitBtn];
    exitBtn.buttonBlock = ^(id sender)
    {
        if ([AppInfo shareAppInfoManager].bLoginSuccess)
        {
            LoginOutModel *model = [[LoginOutModel alloc] init];
            NSDictionary *params = [NSDictionary dictionaryWithObject:[UserInfoManager shareUserInfoManager].userInfo.userLoginName forKey:@"userLoginName"];
            [model requestDataWithParams:params success:^(id object) {
                if([model.resultCode isEqualToString:@"1"])
                {
                    [UserInfoManager shareUserInfoManager].userInfo = nil;
                    [AppInfo shareAppInfoManager].bLoginSuccess = NO;
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:@"NO" forKey:@"autoLogin"];
                    [defaults removeObjectForKey:@"password"];
                    [self popCanvasWithArgment:nil];
                }
            } fail:^(id object) {
                
            }];
        }

    };
    
    self.scrollView.contentSize = CGSizeMake(300, 750);
    
    [self enEnableEdit:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
    
    __weak PersonInfoViewController *weakSelf= self;
    NSString *rightBtnName = @"编辑";
    if (self.editState)
    {
        rightBtnName = @"完成";
    }
    [self setNavigationBarRightItem:rightBtnName itemNormalImg:nil itemHighlightImg:nil withBlock:^(id sender) {
        __strong PersonInfoViewController *strongSelf = weakSelf;
        [strongSelf enEnableEdit:!strongSelf.editState];
        if (!strongSelf.editState)
        {
            [strongSelf modifyUserInfo];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dictionary = (NSDictionary *)argumentData;
        SchoolData *schoolData = [dictionary objectForKey:@"schoolData"];
        if (schoolData)
        {
            self.userInfo.schoolId = schoolData.schoolId;
            self.userInfo.schoolName = schoolData.name;
            [self.schoolBtn setTitle:schoolData.name forState:UIControlStateNormal];
        }
        InstituteData *instituteDta = [dictionary objectForKey:@"instituteData"];
        if (instituteDta)
        {
            self.userInfo.instituteId = instituteDta.instituteId;
            self.userInfo.instituteName = instituteDta.name;
            [self.instituteBtn setTitle:instituteDta.name forState:UIControlStateNormal];
        }
        
        MajorData *majorData = [dictionary objectForKey:@"majorData"];
        if (majorData)
        {
            self.userInfo.majorId = majorData.majorId;
            self.userInfo.majorName = majorData.name;
            [self.majorBtn setTitle:majorData.name forState:UIControlStateNormal];
        }
        
        NSString *startYear = [dictionary objectForKey:@"StartYear"];
        if (startYear)
        {
            self.userInfo.enterSchoolYear = startYear;
            [self.startYearBtn setTitle:startYear forState:UIControlStateNormal];
        }
        
        NSInteger sex = [[dictionary objectForKey:@"Sex"] integerValue];
        if (sex >= 0)
        {
            self.userInfo.gender = [NSString stringWithFormat:@"%d",sex + 1];
            if (sex == 0)
            {
                [self.sexBtn setTitle:@"男" forState:UIControlStateNormal];
            }
            else if(sex == 1)
            {
                [self.sexBtn setTitle:@"女" forState:UIControlStateNormal];
            }
        }
    }

}

- (void)enEnableEdit:(BOOL)state
{
    [_studentNumber resignFirstResponder];
    [_longMobile resignFirstResponder];
    [_shortMobile resignFirstResponder];
    [_email resignFirstResponder];
    
    _editState = state;
    UIBarButtonItem *rightItem = self.navigationItem.rightBarButtonItem;
    if (rightItem)
    {
        UIButton *rightBtn =  (UIButton *)rightItem.customView;
        if (_editState)
        {
            [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        }
        else
        {
            [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }
    }

    _headBtn.enabled = state;
    _schoolBtn.enabled = state;
    _instituteBtn.enabled = state;
    _majorBtn.enabled = state;
    _startYearBtn.enabled = state;
    _studentNumber.enabled = state;
    _longMobile.enabled = state;
    _shortMobile.enabled = state;
    _sexBtn.enabled = state;
    _email.enabled = state;
}
#pragma mark -选择头像
- (void)OnSelectHead:(id)sender
{
    
}

#pragma mark - sexDialog
- (void)showSexDialog
{
    [self hideKeyBoard];
    EWPDialog *sexDialog = [[EWPDialog alloc] initWithTitle:@"请选择性别" message:nil parentView:self.view];
    CGRect frame = sexDialog.frame;
    frame.origin.y += 180;
    frame.size.height -= 250;
    sexDialog.frame = frame;
    sexDialog.backTouchHide = NO;
    sexDialog.maskValue = 0.5;
    sexDialog.titleColor = [UIColor blackColor];
    sexDialog.backgroundColor = [UIColor whiteColor];
    
    if (_sexView == nil)
    {
        _sexView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, sexDialog.frame.size.width - 20, 80) style:UITableViewStylePlain];
        _sexView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _sexView.delegate = self;
        _sexView.dataSource = self;
    }
    [sexDialog addSubview:_sexView];
    
    [sexDialog setLeftBtnTitle:@"确认" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
        
    }];
    
    [sexDialog setRightBtnTitle:@"取消" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
        
    }];
    [sexDialog show];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"男";
    }
    else
    {
        cell.textLabel.text = @"女";
    }
    return cell;
}

#pragma mark - UItableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = nil;
    if (indexPath.row == 0)
    {
        str = @"男";
    }
    else if(indexPath.row == 1)
    {
        str = @"女";
    }
    NSLog(@"indexPath.row = %d;content:%@",indexPath.row,str);
}

#pragma mark - 选择学校

- (void)OnSelectSchool:(id)sender
{
    [self hideKeyBoard];
    [self pushCanvas:NSStringFromClass([SchooListViewController class]) withArgument:nil];
}

#pragma mark - 选择分院

- (void)OnSelectInstitute:(id)sender
{
    [self hideKeyBoard];
    SchoolData *schoolData = [[SchoolData alloc] init];
    schoolData.schoolId = self.userInfo.schoolId;
    schoolData.name = self.userInfo.schoolName;
    [self pushCanvas:NSStringFromClass([InstituteListViewController class]) withArgument:[NSDictionary dictionaryWithObject:schoolData forKey:@"campusData"]];
}
#pragma mark - 选择专业
- (void)OnSelectMajor:(id)sender
{
    [self hideKeyBoard];
    [self hideKeyBoard];
    SchoolData *schoolData = [[SchoolData alloc] init];
    schoolData.schoolId = self.userInfo.schoolId;
    schoolData.name = self.userInfo.schoolName;
    
    InstituteData *instituteData = [[InstituteData alloc] init];
    instituteData.instituteId = self.userInfo.instituteId;
    instituteData.name = self.userInfo.instituteName;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:schoolData,@"schoolData",instituteData,@"instituteData", nil];
    [self pushCanvas:NSStringFromClass([MajorListViewController class]) withArgument:params];
}

#pragma mark-提交信息

- (void)modifyUserInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userInfo.schoolId forKey:@"schoolId"];
    [params setObject:self.userInfo.email forKey:@"email"];
    [params setObject:self.userInfo.enterSchoolYear forKey:@"enterSchoolYear"];
    [params setObject:self.userInfo.gender forKey:@"gender"];
    [params setObject:self.userInfo.imQQ forKey:@"imQQ"];
    [params setObject:self.userInfo.imWeiXin forKey:@"imWeiXin"];
    [params setObject:self.userInfo.instituteId forKey:@"instituteId"];
    [params setObject:self.userInfo.majorId forKey:@"majorId"];
    [params setObject:self.userInfo.mobile forKey:@"mobile"];
    [params setObject:self.userInfo.name forKey:@"name"];
    if (self.userInfo.nickName && [self.userInfo.nickName length])
    {
        [params setObject:self.userInfo.nickName forKey:@"nickName"];
    }
    
    [params setObject:self.userInfo.shortMobile forKey:@"shortMobile"];
    [params setObject:self.userInfo.studentNumber forKey:@"studentNumber"];
    [params setObject:self.userInfo.userId forKey:@"userId"];
    [params setObject:self.userInfo.userLoginName forKey:@"userLoginName"];
    [self requestDataWithAnalyseModel:[ModifyUserInfoModel class] params:params success:^(id object) {
        [self showAlertView:nil message:@"修改成功" confirm:nil cancel:nil];
    } fail:^(id object) {
        
    }];
    
}

#pragma mark - hideKeyBoard
- (void)hideKeyBoard
{
    [_longMobile resignFirstResponder];
    [_shortMobile resignFirstResponder];
    [_studentNumber resignFirstResponder];
    [_email resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
