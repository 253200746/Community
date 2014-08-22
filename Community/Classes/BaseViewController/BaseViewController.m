//
//  BaseViewController.m
//  Community
//
//  Created by andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"F7F7F7"];
    
    //设置导航栏字体属性和背景
    [[UINavigationBar appearance] setBackgroundImage:[CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"48BA3B"] size:CGSizeMake(SCREEN_WIDTH, 44)] forBarMetrics:UIBarMetricsDefault];
    if (ISBIGSYSTEM7)
    {
        [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont boldSystemFontOfSize:20]}];
    }
    
    __weak BaseViewController *weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"backNormal"] itemHighlightImg:[UIImage imageNamed:@"backHighligt"] withBlock:^(id sender) {
        __strong BaseViewController *strongself = weakself;
        [strongself popCanvasWithArgment:nil];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.title = self.title;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLeftMenu
{
    
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"LeftMenuNormal"] itemHighlightImg:[UIImage imageNamed:@"LeftMenuHighlight"] withBlock:^(id sender) {
        if ([AppDelegate shareAppDelegate].lrSliderMenuViewController.LeftMenuShowing)
        {
            [[AppDelegate shareAppDelegate].lrSliderMenuViewController showRootViewController];
        }
        else
        {
            [[AppDelegate shareAppDelegate].lrSliderMenuViewController showLeftView];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
