//
//  MySuggestionViewController.m
//  Community
//
//  Created by Andy on 14-6-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MySuggestionViewController.h"
#import "FeedBackModel.h"
#import "UserInfoManager.h"

@interface MySuggestionViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *textView;
@end

@implementation MySuggestionViewController

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
    self.title = @"我的意见";
    
    CGFloat nYOffset = 20;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, nYOffset, 280, 20)];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"亲，有啥意见您尽管提";
    lable.font = [UIFont systemFontOfSize:17.0f];
    lable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lable];
    nYOffset += 20;
    nYOffset += 10;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, nYOffset, 280, 80)];
    _textView.delegate = self;
    _textView.layer.borderWidth = 1.0f;
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_textView];
    nYOffset += 80;
    nYOffset +=20;
    
    EWPButton *commitBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(20, nYOffset, 280, 40);
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[CommonFuction colorFromHexRGB:@"49BA44"]];
    commitBtn.layer.cornerRadius = 5.0f;
    [self.view addSubview:commitBtn];
    __weak typeof(self) weakSelf = self;
    commitBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        //提交意见请求
        [strongSelf performSelector:@selector(submitFeeadBack) withObject:nil withObject:nil];
    };
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitFeeadBack
{
    if ([_textView.text length] == 0)
    {
        [self showAlertView:nil message:@"请输入您的宝贵意见" confirm:nil cancel:nil];
        return;
    }
    [_textView resignFirstResponder];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_textView.text forKey:@"info"];
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
    if (userInfo && userInfo.userId)
    {
        [params setObject:userInfo.userId forKey:@"userId"];
    }
    [self requestDataWithAnalyseModel:[FeedBackModel class] params:params success:^(id object) {
        FeedBackModel *model = (FeedBackModel *)object;
        if (model && [model.resultCode isEqualToString:@"1"])
        {
            [self showAlertView:nil message:@"提交成功，谢谢您宝贵意见" confirm:nil cancel:nil];
            _textView.text = @"";
        }
    } fail:^(id object) {
        
    }];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
@end
