//
//  InfoDetailViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "NewsDetailModel.h"

@interface InfoDetailViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UITextField *textField;
@end

@implementation InfoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseCanvasType = kbaseScroolViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"资讯详情";
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - 40);
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, 300, self.scrollView.frame.size.height)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.delegate = self;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.userInteractionEnabled = NO;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_webView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 44 - 40 + 5, 300, 30)];
    _textField.layer.cornerRadius = 5.0f;
    _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textField.layer.borderWidth = 1.0f;
    _textField.placeholder = @"回复活动";
    [self.view addSubview:_textField];
    
    [self getData];
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

- (void)getData
{
    NSDictionary *param = [NSDictionary dictionaryWithObject:self.newsId forKey:@"newsId"];
    [self requestDataWithAnalyseModel:[NewsDetailModel class] params:param success:^(id object) {
        NewsDetailModel *model = (NewsDetailModel *)object;
        if (model && [model.resultCode isEqualToString:@"1"])
        {
            [self.webView loadHTMLString:model.content baseURL:nil];
        }
    } fail:^(id object) {
        
    }];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=300;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    height += 40;
    CGRect rect = webView.frame;
    rect.size.height = height;
    webView.frame = rect;
    
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);

    CGSize size = self.scrollView.contentSize;
    size.height += height;
    self.scrollView.contentSize = size;

}

@end
