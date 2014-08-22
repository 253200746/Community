//
//  AppDelegate.h
//  Community
//
//  Created by andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRSliderMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UITabBarController *tabBarController;
@property (nonatomic,strong) LRSliderMenuViewController *lrSliderMenuViewController;
@property (nonatomic,strong) UINavigationController *mainNavigationController;

+ (AppDelegate *)shareAppDelegate;
- (void)showHomeView;
- (void)autoLogin;
@end
