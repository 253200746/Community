//
//  RegesterInfoViewController.m
//  Community
//
//  Created by Andy on 14-6-22.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "RegesterInfoViewController.h"
#import "SchooListViewController.h"
#import "SchoolListModel.h"
#import "InstituteListViewController.h"
#import "MajorListViewController.h"
#import "InstituteListModel.h"
#import "MajorListModel.h"
#import "UserInfo.h"
#import "RegisterModel.h"
#import "StarYearViewController.h"
#import "SexViewController.h"
#import "SchoolListModel.h"

@interface RegesterInfoViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) InstituteData *instituteData;
@property (nonatomic,strong) MajorData *majorData;
@property (nonatomic,assign) NSInteger gender;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) SchoolData *schoolData;
@end

@implementation RegesterInfoViewController

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
    self.title = @"注册";
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    int nYOffset = 20;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, nYOffset, SCREEN_WIDTH - 40, 100)];
    backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    backView.layer.borderWidth = 1.0f;
    [self.scrollView addSubview:backView];
    nYOffset += 100;
    nYOffset += 10;
    
    _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    _photoView.image = [UIImage imageNamed:@"headerdefault"];
    [backView addSubview:_photoView];
    
    EWPButton *locaolPhotoBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    locaolPhotoBtn.frame = CGRectMake(100, 40, 80, 20);
    locaolPhotoBtn.backgroundColor = [UIColor clearColor];
    [locaolPhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [locaolPhotoBtn setTitle:@"本地照片" forState:UIControlStateNormal];
    [backView addSubview:locaolPhotoBtn];
    locaolPhotoBtn.buttonBlock = ^(id sender)
    {
        [self hideKeyBoard];
    };
    
    EWPButton *takePhotoBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame = CGRectMake(180, 40, 100, 20);
    takePhotoBtn.backgroundColor = [UIColor clearColor];
    [takePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [backView addSubview:takePhotoBtn];
    takePhotoBtn.buttonBlock = ^(id sender)
    {
        [self hideKeyBoard];
        
    };
   
    backView = [[UIView alloc] initWithFrame:CGRectMake(20, nYOffset, SCREEN_WIDTH - 40, 400)];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.scrollView addSubview:backView];
    nYOffset += 400;
    nYOffset += 20;
    
    int nXOffset = 10;
    int nSubYOffset = 10;
    //真实姓名
    UILabel *asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"真实姓名";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _name = [[UITextField alloc] initWithFrame:CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20)];
    _name.placeholder = @"请输入真实姓名";
    _name.delegate = self;
    [backView addSubview:_name];
    nSubYOffset += 30;
    
    UIImageView *lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];
    
    //用户名
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"用户名";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20)];
    _userName.placeholder = @"请输入手机号码";
    _userName.delegate = self;
    _userName.userInteractionEnabled = NO;
    [backView addSubview:_userName];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];
    
    //密码
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"密码";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20)];
    _password.placeholder = @"请输入密码";
    _password.delegate = self;
    _password.secureTextEntry = YES;
    [backView addSubview:_password];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];

    //确认密码
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"确认密码";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20)];
    _confirmPassword.placeholder = @"请再次确认密码";
    _confirmPassword.delegate = self;
    _confirmPassword.secureTextEntry = YES;
    [backView addSubview:_confirmPassword];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];
    
    //所在学校
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"所在学校";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _schoolBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _schoolBtn.frame = CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20);
    [_schoolBtn setTitle:@"请选择学校" forState:UIControlStateNormal];
    _schoolBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [_schoolBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _schoolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _schoolBtn.contentEdgeInsets = UIEdgeInsetsZero;
    __weak RegesterInfoViewController *weakSelf = self;
    _schoolBtn.buttonBlock = ^(id sender)
    {
        __strong RegesterInfoViewController *strongSelf = weakSelf;
        [strongSelf hideKeyBoard];
        [strongSelf pushCanvas:NSStringFromClass([SchooListViewController class]) withArgument:nil];
    };
    [backView addSubview:_schoolBtn];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_schoolBtn.frame.size.width - 20, 0, 12, 20)];
    arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [_schoolBtn addSubview:arrowImageView];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];
    
    //所在分院
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"所在分院";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _collegeBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _collegeBtn.frame = CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20);
    [_collegeBtn setTitle:@"请选择学院" forState:UIControlStateNormal];
    _collegeBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [_collegeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _collegeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _collegeBtn.contentEdgeInsets = UIEdgeInsetsZero;
    _collegeBtn.buttonBlock = ^(id sender)
    {
         __strong RegesterInfoViewController *strongSelf = weakSelf;
         [strongSelf hideKeyBoard];
        if (strongSelf.schoolData == nil)
        {
            [strongSelf showAlertView:nil message:@"请先选择学校" confirm:nil cancel:nil];
            return ;
        }

        [strongSelf pushCanvas:NSStringFromClass([InstituteListViewController class]) withArgument:strongSelf.schoolData];
    };
    [backView addSubview:_collegeBtn];
    
    arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_schoolBtn.frame.size.width - 20, 0, 12, 20)];
    arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [_collegeBtn addSubview:arrowImageView];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];
    
    //所学专业
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"所学专业";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _majorBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _majorBtn.frame = CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20);
    [_majorBtn setTitle:@"请选择专业" forState:UIControlStateNormal];
    _majorBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [_majorBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _majorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _majorBtn.contentEdgeInsets = UIEdgeInsetsZero;
    _majorBtn.buttonBlock = ^(id sender)
    {
        __strong RegesterInfoViewController *strongSelf = weakSelf;
        [strongSelf hideKeyBoard];
        if (strongSelf.schoolData == nil)
        {
            [strongSelf showAlertView:nil message:@"请先选择学校" confirm:nil cancel:nil];
            return ;
        }
        if (strongSelf.instituteData == nil)
        {
            [strongSelf showAlertView:nil message:@"请先选择学院" confirm:nil cancel:nil];
            return;
        }

        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:strongSelf.instituteData,@"instituteData", nil];
        [strongSelf pushCanvas:NSStringFromClass([MajorListViewController class]) withArgument:params];
    };
    [backView addSubview:_majorBtn];
    
    arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_schoolBtn.frame.size.width - 20, 0, 12, 20)];
    arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [_majorBtn addSubview:arrowImageView];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];
    
    //入学年份
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"入学年份";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _starYearBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _starYearBtn.frame = CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20);
    [_starYearBtn setTitle:@"请输入入学年份" forState:UIControlStateNormal];
    _starYearBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [_starYearBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _starYearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _starYearBtn.contentEdgeInsets = UIEdgeInsetsZero;
    _starYearBtn.buttonBlock = ^(id sender)
    {
        __strong RegesterInfoViewController *strongSelf = weakSelf;
        [strongSelf hideKeyBoard];
        [strongSelf pushCanvas:NSStringFromClass([StarYearViewController class]) withArgument:nil];
    };
    [backView addSubview:_starYearBtn];
    arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_schoolBtn.frame.size.width - 20, 0, 12, 20)];
    arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [_starYearBtn addSubview:arrowImageView];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];
    
    
    //学号
    nSubYOffset += 10;
    asteriskL = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset, nSubYOffset + 3, 5, 20)];
    asteriskL.text = @"*";
    asteriskL.textColor = [UIColor redColor];
    asteriskL.backgroundColor = [UIColor clearColor];
    asteriskL.textAlignment = NSTextAlignmentCenter;
    asteriskL.font = [UIFont systemFontOfSize:17.0f];
    [backView addSubview:asteriskL];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"学号";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _studentId = [[UITextField alloc] initWithFrame:CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20)];
    _studentId.placeholder = @"请确认学号";
    _studentId.delegate = self;
    [backView addSubview:_studentId];
    nSubYOffset += 30;
    
    lineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nSubYOffset, backView.frame.size.width, 1)];
    lineImgeView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineImgeView];

    //性别
    nSubYOffset += 10;
    lable = [[UILabel alloc] initWithFrame:CGRectMake(nXOffset + 5, nSubYOffset, 80, 20)];
    lable.text = @"性别";
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.backgroundColor = [UIColor clearColor];
    [backView addSubview:lable];
    
    _sexBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _sexBtn.frame = CGRectMake(nXOffset + 5 + 80, nSubYOffset, backView.frame.size.width - nXOffset - 85, 20);
    [_sexBtn setTitle:@"请选择性别" forState:UIControlStateNormal];
    _sexBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [_sexBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _sexBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sexBtn.contentEdgeInsets = UIEdgeInsetsZero;
    _sexBtn.buttonBlock = ^(id sender)
    {
        __strong RegesterInfoViewController *strongSelf = weakSelf;
        [strongSelf hideKeyBoard];
        [strongSelf pushCanvas:NSStringFromClass([SexViewController class]) withArgument:nil];
        
    };
    [backView addSubview:_sexBtn];
    
    arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_schoolBtn.frame.size.width - 20, 0, 12, 20)];
    arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [_sexBtn addSubview:arrowImageView];
    nSubYOffset += 30;
    
    
    //注册按钮
    EWPButton *registerBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, nYOffset, SCREEN_WIDTH - 40, 40);
    registerBtn.layer.cornerRadius = 5.0f;
    registerBtn.backgroundColor = [CommonFuction colorFromHexRGB:@"49BA44"];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.scrollView addSubview:registerBtn];
    nYOffset += 40;
    nYOffset += 20;
    registerBtn.buttonBlock = ^(id sender)
    {
        [self hideKeyBoard];
        [self performSelectorOnMainThread:@selector(OnRegiser) withObject:nil waitUntilDone:NO];
    };
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, nYOffset + 50);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
    self.userName.text = self.mobile;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideKeyBoard];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = YES;
}

#pragma mark -baseViewController

-(void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dictionary = (NSDictionary *)argumentData;
        NSString *mobile = [dictionary objectForKey:@"mobile"];
        if (mobile && [mobile length])
        {
            self.mobile = mobile;
        }
        
        SchoolData *schoolData = [dictionary objectForKey:@"schoolData"];
        if (schoolData)
        {
            self.schoolData = schoolData;
            [self.schoolBtn setTitle:schoolData.name forState:UIControlStateNormal];
        }
        
        InstituteData *instituteDta = [dictionary objectForKey:@"instituteData"];
        if (instituteDta)
        {
            self.instituteData = instituteDta;
            [self.collegeBtn setTitle:instituteDta.name forState:UIControlStateNormal];
        }
        
        MajorData *majorData = [dictionary objectForKey:@"majorData"];
        if (majorData)
        {
            self.majorData = majorData;
            [self.majorBtn setTitle:majorData.name forState:UIControlStateNormal];
        }
        
        NSString *startYear = [dictionary objectForKey:@"StartYear"];
        if (startYear)
        {
            [self.starYearBtn setTitle:startYear forState:UIControlStateNormal];
        }
        
        NSInteger sex = [[dictionary objectForKey:@"Sex"] integerValue];
        if (sex >= 0)
        {
            self.gender = sex + 1;
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

#pragma mark UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -OnRegiser
- (void)OnRegiser
{
    if (_name.text == nil)
    {
        [self showAlertView:nil message:@"真实姓名不能为空！" confirm:nil cancel:nil];
        return;
    }
    if (_userName.text == nil)
    {
        [self showAlertView:nil message:@"用户名不能为空！" confirm:nil cancel:nil];
        return;
    }
    
    if (_password.text == nil)
    {
        [self showAlertView:nil message:@"密码不能为空！" confirm:nil cancel:nil];
        return;
    }
    
    if (_confirmPassword == nil)
    {
        [self showAlertView:nil message:@"确认密码不能为空！" confirm:nil cancel:nil];
        return;
    }
    if (![_password.text isEqualToString:_confirmPassword.text])
    {
        [self showAlertView:nil message:@"两次密码输入不一致！" confirm:nil cancel:nil];
        return;
    }
    if (self.schoolData == nil)
    {
        [self showAlertView:nil message:@"请选择所在学校！" confirm:nil cancel:nil];
        return;
    }
    if (self.instituteData == nil)
    {
        [self showAlertView:nil message:@"请选择所在学院！" confirm:nil cancel:nil];
        return;
    }
    if (self.majorData == nil)
    {
        [self showAlertView:nil message:@"请选择所属专业！" confirm:nil cancel:nil];
        return;
    }
    if (_starYearBtn.titleLabel.text == nil)
    {
        [self showAlertView:nil message:@"请选择入学年份！" confirm:nil cancel:nil];
        return;
    }
    if (_studentId.text == nil)
    {
        [self showAlertView:nil message:@"学号不能为空！" confirm:nil cancel:nil];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (param)
    {
        [param setObject:self.schoolData.schoolId forKey:@"schoolId"];
        [param setObject:_starYearBtn.titleLabel.text forKey:@"enterSchoolYear"];
        [param setObject:[NSString stringWithFormat:@"%d",self.gender] forKey:@"gender"];
        [param setObject:self.instituteData.instituteId forKey:@"instituteId"];
        [param setObject:_userName.text forKey:@"userLoginName"];
        [param setObject:self.majorData.majorId forKey:@"majorId"];
        [param setObject:_userName.text forKey:@"mobile"];
        [param setObject:_name.text forKey:@"name"];
        [param setObject:_password.text forKey:@"password"];
        [param setObject:_studentId.text forKey:@"studentNumber"];
    
        [self requestDataWithAnalyseModel:[RegisterModel class] params:param success:^(id object) {
            RegisterModel *model = (RegisterModel *)object;
            if ([model.resultCode isEqualToString:@"1"])
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"YES" forKey:@"autoLogin"];
                [defaults setObject:self.userName.text forKey:@"loginName"];
                [defaults setObject:_password.text forKey:@"password"];
                [defaults synchronize];
                
                [[AppDelegate shareAppDelegate] autoLogin];
                [self showAlertView:nil message:@"注册成功" confirm:^(id sender) {
                    [[AppDelegate shareAppDelegate] showHomeView];
                } cancel:nil];
            }
            else
            {
                [self showAlertView:nil message:model.message confirm:nil cancel:nil];
            }
        } fail:^(id object) {
            
        }];
    }
}

#pragma mark - hideKeyBoard
- (void)hideKeyBoard
{
    [_name resignFirstResponder];
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];
    [_studentId resignFirstResponder];
    [_name resignFirstResponder];
}

#pragma mark - showSexDialog

#pragma mark - showStudentIDDialog

#pragma mark - showYearDialog


@end
