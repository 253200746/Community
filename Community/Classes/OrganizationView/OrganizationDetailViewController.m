//
//  OrganizationDetailViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "OrganizationDetailViewController.h"
#import "BaseTableCanvas.h"

@interface OrganizationDetailViewController ()
@property (nonatomic,strong) UIView *baseInfoView;
@property (nonatomic,strong) UIView *tabBarView;
@property (nonatomic,strong) UIWebView *webViw;
@property (nonatomic,strong) BaseTableCanvas *activityListView;
@end

@implementation OrganizationDetailViewController

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
    self.title = @"组织详情";
    int nYOffset = 0;
    _baseInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset, 320, 150)];
    _baseInfoView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_baseInfoView];
    nYOffset += 150;
    
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, nYOffset, 320, 40)];
    _tabBarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tabBarView];
    
    _webViw = [[UIWebView alloc] initWithFrame:CGRectMake(0, nYOffset, 320, self.view.frame.size.height - 44 - nYOffset)];
    _webViw.backgroundColor = [UIColor redColor];
    [self.view addSubview:_webViw];
    
    _activityListView = [[BaseTableCanvas alloc] initWithFrame:CGRectMake(0, nYOffset, 320, self.view.frame.size.height - 44 - nYOffset) style:UITableViewStylePlain];
    [self.view addSubview:_activityListView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
    [self getData];
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

- (void)getData
{
    
}

@end
