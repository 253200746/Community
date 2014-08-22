//
//  LeftViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "HelpViewController.h"
#import "MyMessageViewController.h"
#import "MyFavoriteViewController.h"
#import "MyActivityViewController.h"
#import "MyPartnerViewController.h"
#import "MySuggestionViewController.h"
#import "PersonInfoViewController.h"
#import "LoginViewController.h"
#import "UserInfoManager.h"
#import "AppInfo.h"

@interface LeftViewController ()
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *place;
@end

@implementation LeftViewController

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
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineImage];
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.tag = 0;
    headBtn.frame = CGRectMake(0, nYOffset, 280, 70);
    [headBtn setBackgroundImage:[CommonFuction imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(260, 70)] forState:UIControlStateHighlighted];
    [headBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headBtn];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 25, 12, 20)];
    arrowImgView.image = [UIImage imageNamed:@"arrow"];
    [headBtn addSubview:arrowImgView];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
    headImageView.image = [UIImage imageNamed:@"headerdefault"];
    headImageView.backgroundColor = [UIColor grayColor];
    [headBtn addSubview:headImageView];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 200, 20)];
    _name.text = @"未登录";
    _name.font = [UIFont systemFontOfSize:17.0f];
    _name.backgroundColor = [UIColor clearColor];
    [headBtn addSubview:_name];
    
    _place = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 200, 20)];
    _place.text = @"未显示学校名称";
    _place.font = [UIFont systemFontOfSize:15.0f];
    _place.backgroundColor = [UIColor clearColor];
    [headBtn addSubview:_place];
    nYOffset += 70;
    
    lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineImage];
    
    
    nYOffset += 10;
    
    NSArray *iconArray = @[@"LeftMessae",@"LeftFavorite",@"LeftActivity",@"LeftPartner",@"LeftSuggestion",@"LeftHelp"];
    NSArray *titleArray = @[@"我的消息",@"我感兴趣的活动",@"我参加的活动",@"我的求伴",@"我的意见",@"帮助"];
    
    lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 1)];
    lineImage.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineImage];
    
    CGFloat menuHeight = 40;
    for (int nIndex = 0; nIndex < [iconArray count]; nIndex++)
    {
        UIButton *menu = [[UIButton alloc] initWithFrame:CGRectMake(0, nYOffset , 280, menuHeight)];
        menu.tag = nIndex + 1;
        [menu setBackgroundImage:[CommonFuction imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(260, menuHeight)] forState:UIControlStateHighlighted];
        [menu addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *icon = [UIImage imageNamed:iconArray[nIndex]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (menuHeight - icon.size.height)/2, icon.size.width, icon.size.height)];
        imageView.image = icon;
        [menu addSubview:imageView];
        [self.view addSubview:menu];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 8, 12, 20)];
        arrowImgView.image = [UIImage imageNamed:@"arrow"];
        [menu addSubview:arrowImgView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10 + icon.size.width + 10, (menuHeight - 20)/2, 130, 20)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:15.0f];
        title.text = titleArray[nIndex];
        [menu addSubview:title];
        
        nYOffset += menuHeight;
        lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 1)];
        lineImage.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineImage];
    }
    
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController addObserver:self forKeyPath:@"LeftMenuShowing" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([AppInfo shareAppInfoManager].bLoginSuccess)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
        if (userInfo)
        {
            self.name.text = userInfo.name;
            self.place.text = userInfo.schoolName;
        }

    }
    else
    {
        self.name.text = @"未登录";
        self.place.text = @"未显示学校名称";
    }
}

- (void)OnClick:(id)sender
{
     [[AppDelegate shareAppDelegate].lrSliderMenuViewController showRootViewController];
    UIButton *button = (UIButton *)sender;
    NSLog(@"button.tag = %d",button.tag);
    UIViewController *viewController = nil;
    switch (button.tag)
    {
        case 0:
        {
            //个人信息
            viewController = [[PersonInfoViewController alloc] init];
        }
            break;
        case 1:
        {
            //我的消息
            viewController = [[MyMessageViewController alloc] init];
        }
            break;
        case 2:
        {
            //我感兴趣的活动
            viewController = [[MyFavoriteViewController alloc] init];
        }
            break;
        case 3:
        {
            //我参加的活动
            viewController = [[MyActivityViewController alloc] init];
        }
            break;
        case 4:
        {
            //我得求伴
            viewController = [[MyPartnerViewController alloc] init];
        }
            break;
        case 5:
        {
            //我得意见
            viewController = [[MySuggestionViewController alloc] init];
 
        }
            break;
        case 6:
        {
            //帮助
            viewController = [[HelpViewController alloc] init];
        }
            break;
        default:
            break;
    }
    if (button.tag != 6)
    {
        if (![AppInfo shareAppInfoManager].bLoginSuccess)
        {
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            loginViewController.fromLeftMenu = YES;
            viewController = loginViewController;
        }
    }
    [[AppDelegate shareAppDelegate].mainNavigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"LeftMenuShowing"])
    {
        BOOL leftMenuShowing = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (leftMenuShowing)
        {
            [self viewWillAppear:NO];
        }
        
    }
}
@end
