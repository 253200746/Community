//
//  AppDelegate.m
//  Community
//
//  Created by andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "AppDelegate.h"

#import "LeftViewController.h"
#import "MainViewController.h"
#import "ActivityViewController.h"
#import "OrganizationViewController.h"
#import "InfoViewController.h"
#import "NeedPartnerViewController.h"
#import "ToolViewController.h"
#import "LoginModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "SchooListViewController.h"
#import "AppInfo.h"
#import "NSString+MD5.h"

@interface AppDelegate ()<UINavigationControllerDelegate>

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //在程序中注册推送通知
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"schoolId"])
    {
        [AppInfo shareAppInfoManager].schoolId = [defaults objectForKey:@"schoolId"];
        [AppInfo shareAppInfoManager].schoolName = [defaults objectForKey:@"schoolName"];
        [self autoLogin];
        [self showHomeView];
    }
    else
    {
        SchooListViewController *viewController = [[SchooListViewController alloc] init];
        viewController.bRootViewController = YES;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        self.window.rootViewController = navigationController;
    }
    [self checkVersion];
    [self.window makeKeyAndVisible];
    
    return YES;
}

+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController == _mainNavigationController && [viewController isKindOfClass:[UITabBarController class]])
    {
        self.lrSliderMenuViewController.canShowLeftMenu = YES;
    }
    else
    {
        self.lrSliderMenuViewController.canShowLeftMenu = NO;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *devicetokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    devicetokenStr = [devicetokenStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    devicetokenStr = [devicetokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    [AppInfo shareAppInfoManager].deviceToken = devicetokenStr;
    
}
- (void)autoLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"autoLogin"])
    {
        BOOL bAutoLogin = [[defaults objectForKey:@"autoLogin"] boolValue];
        if (!bAutoLogin)
        {
            return;
        }
        NSString *loginName = [defaults objectForKey:@"loginName"];
        NSString *password = [defaults objectForKey:@"password"];
        
        if (loginName && password)
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:loginName forKey:@"userLoginName"];
            [params setObject:[password md5]forKey:@"password"];
            
            LoginModel *model = [[LoginModel alloc] init];
            [model requestDataWithParams:params success:^(id object) {
                if ([model.resultCode isEqualToString:@"1"])
                {

                    [AppInfo shareAppInfoManager].bLoginSuccess = YES;
                    [UserInfoManager shareUserInfoManager].userInfo = model.userInfo;
                }
            } fail:^(id object) {
                
            }];
        }
        
    }
    

}

- (void)showHomeView
{
    _tabBarController = [[UITabBarController alloc] init];
    NSArray *array = [_tabBarController.view subviews];
    UITabBar *tabBar = [array objectAtIndex:1];
    UIImage *image = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"F2F2F2"] size:CGSizeMake(SCREEN_WIDTH, 40)];
    tabBar.layer.contents = (id)image.CGImage;
    
    UIViewController *activityViewController = [[ActivityViewController alloc] init];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"活动" image:nil tag:0];
    [item setFinishedSelectedImage:[UIImage imageNamed:@"tabitem11"]
       withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem1"]];
    UINavigationController *activityNav = [[UINavigationController alloc] initWithRootViewController:activityViewController];
    activityNav.tabBarItem = item;
    
    UIViewController * infoViewController = [[InfoViewController alloc] init];
    item = [[UITabBarItem alloc] initWithTitle:@"资讯" image:nil tag:1];
    [item setFinishedSelectedImage:[UIImage imageNamed:@"tabitem22"]
       withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem2"]];
    UINavigationController *infoNav = [[UINavigationController alloc] initWithRootViewController:infoViewController];
    infoNav.tabBarItem = item;
    
    UIViewController *organizationViewController = [[OrganizationViewController alloc] init];
    item = [[UITabBarItem alloc] initWithTitle:@"组织" image:nil tag:2];
    [item setFinishedSelectedImage:[UIImage imageNamed:@"tabitem33"]
       withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem3"]];
    UINavigationController *organizationNav = [[UINavigationController alloc] initWithRootViewController:organizationViewController];
    organizationNav.tabBarItem = item;
    
    UIViewController *needPartnerViewController = [[NeedPartnerViewController alloc] init];
    item = [[UITabBarItem alloc] initWithTitle:@"求伴" image:nil tag:3];
    [item setFinishedSelectedImage:[UIImage imageNamed:@"tabitem44"]
       withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem4"]];
    UINavigationController *needPartnerNav = [[UINavigationController alloc] initWithRootViewController:needPartnerViewController];
    needPartnerNav.tabBarItem = item;
    
    UIViewController *toolViewController = [[ToolViewController alloc] init];
    item = [[UITabBarItem alloc] initWithTitle:@"应用" image:nil tag:4];
    [item setFinishedSelectedImage:[UIImage imageNamed:@"tabitem55"]
       withFinishedUnselectedImage:[UIImage imageNamed:@"tabitem5"]];
    UINavigationController *toolNav = [[UINavigationController alloc] initWithRootViewController:toolViewController];
    toolNav.tabBarItem = item;
    
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                           activityNav,
                                           infoNav,
                                           organizationNav,
                                           needPartnerNav,
                                           toolNav,nil]];
    
    _mainNavigationController= [[UINavigationController alloc] initWithRootViewController:_tabBarController];
    _mainNavigationController.delegate = self;
    _mainNavigationController.navigationBarHidden = YES;
    self.lrSliderMenuViewController = [[LRSliderMenuViewController alloc] initWithRootViewController:_mainNavigationController leftViewController:[[LeftViewController alloc] init]rightViewController:nil];
    self.window.rootViewController = self.lrSliderMenuViewController;
}

- (void)checkVersion
{
    
}

@end
