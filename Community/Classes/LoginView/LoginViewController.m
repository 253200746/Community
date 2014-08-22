//
//  LoginViewController.m
//  Community
//
//  Created by Andy on 14-6-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "VerifyCodeViewController.h"
#import "LoginModel.h"
#import "UserInfoManager.h"
#import "AppInfo.h"
#import "NSString+MD5.h"

@interface LoginViewController ()
@property (nonatomic,strong) UITextField *account;
@property (nonatomic,strong) UITextField *password;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGFloat nYOffset = 10;
    self.title = @"登录";
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, nYOffset, 280, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [CommonFuction colorFromHexRGB:@"DEDEDE"].CGColor;
    backView.layer.cornerRadius = 5;
    [self.view addSubview:backView];
    nYOffset += 100;
    nYOffset += 10;
    
    _account = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 260, 40)];
    _account.placeholder = @"请输入账号";
    _account.leftViewMode = UITextFieldViewModeAlways;
    [backView addSubview:_account];
    UIImageView *accountImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    accountImg.image = [UIImage imageNamed:@"account"];
    _account.leftView = accountImg;
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 260, 1)];
    lineImageView.backgroundColor = [CommonFuction colorFromHexRGB:@"DEDEDE"];
    [backView addSubview:lineImageView];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, 260, 40)];
    _password.placeholder = @"请输入密码";
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.secureTextEntry = YES;
    [backView addSubview:_password];
    UIImageView *passwordImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    passwordImg.image = [UIImage imageNamed:@"password"];
    _password.leftView = passwordImg;
    
    EWPButton *loginBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, nYOffset, 280, 40);
    loginBtn.layer.cornerRadius = 5.0f;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[CommonFuction colorFromHexRGB:@"49BA44"]];
    [self.view addSubview:loginBtn];
    loginBtn.buttonBlock = ^(id sender)
    {
        if ((_account.text && [_account.text length] > 0)
            ||(_password.text && [_password.text length]> 0))
        {
            [_account resignFirstResponder];
            [_password resignFirstResponder];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:_account.text forKey:@"userLoginName"];
            [params setObject:[_password.text md5] forKey:@"password"];
            
            [self requestDataWithAnalyseModel:[LoginModel class] params:params success:^(id object) {
                LoginModel *model = (LoginModel *)object;
                if ([model.resultCode isEqualToString:@"1"])
                {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:@"YES" forKey:@"autoLogin"];
                    [defaults setObject:_account.text forKey:@"loginName"];
                    [defaults setObject:_password.text forKey:@"password"];
                    [defaults synchronize];
                    
                    [AppInfo shareAppInfoManager].bLoginSuccess = YES;
                    [UserInfoManager shareUserInfoManager].userInfo = model.userInfo;
                    [self performSelectorOnMainThread:@selector(loginSuccess) withObject:nil waitUntilDone:NO];
                }
                else
                {
                    [self showAlertView:nil message:model.message confirm:nil cancel:nil];
                }
            } fail:^(id object) {
                
            }];
           
        }

    };
    nYOffset += 40;
    nYOffset += 10;
    
    EWPButton *registerBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    registerBtn.frame = CGRectMake(85, nYOffset, 60, 20);
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [registerBtn setBackgroundColor:[UIColor clearColor]];
    [registerBtn setTitleColor:[CommonFuction colorFromHexRGB:@"7F7F7F"] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    registerBtn.buttonBlock = ^(id sender)
    {
        //注册账号
        [self pushCanvas:NSStringFromClass([RegisterViewController class]) withArgument:nil];
    };
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(150, nYOffset, 14, 20)];
    lable.font = [UIFont systemFontOfSize:15.0f];
    lable.text = @"or";
    [self.view addSubview:lable];
    
    EWPButton *findPasswordBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [findPasswordBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    findPasswordBtn.frame = CGRectMake(170, nYOffset, 60, 20);
    findPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [findPasswordBtn setBackgroundColor:[UIColor clearColor]];
    [findPasswordBtn setTitleColor:[CommonFuction colorFromHexRGB:@"7F7F7F"] forState:UIControlStateNormal];
    [self.view addSubview:findPasswordBtn];
    findPasswordBtn.buttonBlock = ^(id sender)
    {
        //找回密码
        [self pushCanvas:NSStringFromClass([VerifyCodeViewController class]) withArgument:nil];
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.fromLeftMenu)
    {
        [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
    }
    else
    {
        self.navigationController.navigationBarHidden = NO;
    }

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.fromLeftMenu)
    {
        [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginSuccess
{
    //登录成功
    [self popCanvasWithArgment:nil];

}
@end
