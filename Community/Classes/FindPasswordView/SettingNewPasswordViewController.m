//
//  SettingNewPasswordViewController.m
//  Community
//
//  Created by Andy on 14-6-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "SettingNewPasswordViewController.h"
#import "ModifyPasswordModel.h"
#import "NSString+MD5.h"

@interface SettingNewPasswordViewController ()
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *confirmPassword;
@property (nonatomic,strong) NSString *userLoginName;
@end

@implementation SettingNewPasswordViewController

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
    self.title = @"请设置新密码";
    
    CGFloat nYOffset = 10;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, nYOffset, 280, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [CommonFuction colorFromHexRGB:@"DEDEDE"].CGColor;
    backView.layer.cornerRadius = 5;
    [self.view addSubview:backView];
    nYOffset += 100;
    nYOffset += 10;
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 260, 40)];
    _password.placeholder = @"请输入新密码";
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.secureTextEntry = YES;
    [backView addSubview:_password];
    UIImageView *accountImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    accountImg.image = [UIImage imageNamed:@"password"];
    _password.leftView = accountImg;
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 260, 1)];
    lineImageView.backgroundColor = [CommonFuction colorFromHexRGB:@"DEDEDE"];
    [backView addSubview:lineImageView];
    
    _confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, 260, 40)];
    _confirmPassword.placeholder = @"请再次输入新密码";
    _confirmPassword.leftViewMode = UITextFieldViewModeAlways;
    _confirmPassword.secureTextEntry = YES;
    [backView addSubview:_confirmPassword];
    UIImageView *passwordImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    passwordImg.image = [UIImage imageNamed:@"password"];
    _confirmPassword.leftView = passwordImg;
    
    EWPButton *confirmBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(20, nYOffset, 280, 40);
    confirmBtn.layer.cornerRadius = 5.0f;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[CommonFuction colorFromHexRGB:@"49BA44"]];
    [self.view addSubview:confirmBtn];
    
    __weak SettingNewPasswordViewController *weakSelf = self;
    confirmBtn.buttonBlock = ^(id sender)
    {
        __strong SettingNewPasswordViewController *strongSelf = weakSelf;
        //修改密码请求
        if (strongSelf.password == nil)
        {
            [strongSelf showAlertView:nil message:@"密码不能为空" confirm:nil cancel:nil];
            return ;
        }
        
        if (strongSelf.confirmPassword == nil || ![strongSelf.confirmPassword.text isEqualToString:strongSelf.password.text])
        {
            [strongSelf showAlertView:nil message:@"两次输入密码不一致" confirm:nil cancel:nil];
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"yes" forKey:@"f"];
        [params setObject:[_password.text md5] forKey:@"newPassword"];
        [params setObject:self.userLoginName forKey:@"userLoginName"];
        ModifyPasswordModel *model = [[ModifyPasswordModel alloc] init];
        [model requestDataWithParams:params success:^(id object) {
            if ([model.resultCode isEqualToString:@"1"])
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"YES" forKey:@"autoLogin"];
                [defaults setObject:self.userLoginName forKey:@"loginName"];
                [defaults setObject:_password.text forKey:@"password"];
                [defaults synchronize];
                
                [[AppDelegate shareAppDelegate] autoLogin];
                [self showAlertView:nil message:@"密码修改成功" confirm:^(id sender) {
                    [[AppDelegate shareAppDelegate] showHomeView];
                } cancel:nil];

            }
            else
            {
                [self showAlertView:nil message:model.message confirm:nil cancel:nil];
            }
        } fail:^(id object) {
            
        }];
        
    };
    nYOffset += 40;
    nYOffset += 10;

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
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSString class]])
    {
        self.userLoginName = argumentData;
    }
}
@end
