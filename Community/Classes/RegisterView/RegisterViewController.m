//
//  RegisterViewController.m
//  Community
//
//  Created by Andy on 14-6-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegesterInfoViewController.h"
#import "GetVerifyCodeModel.h"
#import "NSString+MD5.h"

@interface RegisterViewController ()
@property (nonatomic,strong) UITextField *mobileText;
@property (nonatomic,strong) EWPButton *getCodeBtn;
@property (nonatomic,strong) UITextField *codeText;
@property (nonatomic,assign) NSInteger timerCount;
@property (nonatomic,strong) NSString *verifyCode;
@end

@implementation RegisterViewController

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
    self.title = @"注册";
    CGFloat nYOffset = 10;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, nYOffset, 280, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [CommonFuction colorFromHexRGB:@"DEDEDE"].CGColor;
    backView.layer.cornerRadius = 5;
    [self.view addSubview:backView];
    nYOffset += 50;
    nYOffset += 10;
    
    _mobileText = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 195, 40)];
    _mobileText.placeholder = @"请输入您的手机号码";
    _mobileText.font = [UIFont systemFontOfSize:15.0f];
    _mobileText.leftViewMode = UITextFieldViewModeAlways;
    [backView addSubview:_mobileText];
    UIImageView *mobileImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    mobileImg.image = [UIImage imageNamed:@"mobile"];
    _mobileText.leftView = mobileImg;
    
    _getCodeBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCodeBtn.layer.cornerRadius = 5.0f;
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _getCodeBtn.frame = CGRectMake(backView.frame.size.width - 5 - 80, 5, 80, 40);
    [_getCodeBtn setBackgroundColor:[CommonFuction colorFromHexRGB:@"49BA44"]];
    __weak RegisterViewController *weakSelf = self;
    _getCodeBtn.buttonBlock = ^(id sender)
    {
        __strong RegisterViewController *strongSelf = weakSelf;
        [strongSelf performSelector:@selector(getCode) withObject:nil];
    };
    [backView addSubview:_getCodeBtn];
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(20, nYOffset, 280, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = 1.0f;
    backView.layer.borderColor = [CommonFuction colorFromHexRGB:@"DEDEDE"].CGColor;
    backView.layer.cornerRadius = 5;
    [self.view addSubview:backView];
    nYOffset += 50;
    nYOffset += 10;
    
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 270, 40)];
    _codeText.placeholder = @"请输入手机验证码";
    _codeText.font = [UIFont systemFontOfSize:15.0f];
    _codeText.leftViewMode = UITextFieldViewModeAlways;
    [backView addSubview:_codeText];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(2, 10, 60, 20)];
    lable.font =  [UIFont systemFontOfSize:15.0f];
    lable.text = @"验证码";
    
    _codeText.leftView = lable;
    
    EWPButton *nextBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(20, nYOffset, 280, 40);
    nextBtn.backgroundColor = [CommonFuction colorFromHexRGB:@"49BA44"];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 5.0f;
    [self.view addSubview:nextBtn];
    nextBtn.buttonBlock = ^(id sender)
    {
        if (0)
        {
            [self pushCanvas:NSStringFromClass([RegesterInfoViewController class]) withArgument:[NSDictionary dictionaryWithObject:_mobileText.text forKey:@"mobile"]];
        }
        else
        {
            NSString *verifyStr = [_codeText.text md5];
            if (verifyStr && [verifyStr isEqualToString:self.verifyCode])
            {
                [self pushCanvas:NSStringFromClass([RegesterInfoViewController class]) withArgument:[NSDictionary dictionaryWithObject:_mobileText.text forKey:@"mobile"]];
            }
            else
            {
                [self showAlertView:nil message:@"验证码不正确" confirm:nil cancel:nil];
            }
        }
    };
   
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
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = YES;
}
#pragma mark - codeTimer

- (void)getCode
{
    if (_mobileText && [_mobileText.text length])
    {
        //要增加验证手机的正则表达式
        GetVerifyCodeModel *model = [[GetVerifyCodeModel alloc] init];
        NSDictionary *param = [NSDictionary dictionaryWithObject:_mobileText.text forKey:@"mobile"];
        [model requestDataWithParams:param success:^(id object) {
            if ([model.resultCode isEqualToString:@"1"])
            {
                self.timerCount = 60;
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(OnTimer:) userInfo:nil repeats:YES];
                self.getCodeBtn.enabled = NO;
                [_getCodeBtn setBackgroundColor:[CommonFuction colorFromHexRGB:@"CBCBCB"]];
                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%d",self.timerCount] forState:UIControlStateNormal];
                
                self.verifyCode = model.verifyStr;
            }
            else
            {
                [self showAlertView:nil message:model.message confirm:nil cancel:nil];
            }
            
        } fail:^(id object) {
            
        }];

    }
}

- (void)OnTimer:(id)sender
{
    NSTimer *timer = (NSTimer *)sender;
    self.timerCount--;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%d",self.timerCount] forState:UIControlStateNormal];
    if (self.timerCount == 0)
    {
        [timer invalidate];
        self.getCodeBtn.enabled = YES;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
         [_getCodeBtn setBackgroundColor:[CommonFuction colorFromHexRGB:@"49BA44"]];
    }
    
}
@end
