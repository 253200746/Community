//
//  ToolDetailViewController.m
//  Community
//
//  Created by Andy on 14-8-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ToolDetailViewController.h"
#import "ToolListModel.h"
#import "AppInfo.h"

@interface ToolDetailViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) ToolData *toolData;
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation ToolDetailViewController

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
    self.title = self.toolData.name;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height - 44)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    if (self.toolData && self.toolData.url)
    {
        NSString *url = [NSString stringWithFormat:@"%@?schoolId=%@",self.toolData.url,[AppInfo shareAppInfoManager].schoolId];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_webView loadRequest:urlRequest];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[ToolData class]])
    {
        self.toolData = argumentData;
    }
}

#pragma mark - UIWebDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
@end
