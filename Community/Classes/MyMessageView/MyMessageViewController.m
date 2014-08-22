//
//  MyMessageViewController.m
//  Community
//
//  Created by Andy on 14-6-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MessageModel.h"
#import "MessageCell.h"
#import "ActivityDetailViewController.h"
#import "InfoDetailViewController.h"
#import "OrganizationDetailViewController.h"
#import "PartnerDetailViewController.h"

@interface MyMessageViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>

@property (nonatomic,strong) NSMutableArray *messageMArray;
@end

@implementation MyMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseCanvasType = kbaseTableViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"我的消息";
    
    self.tableView.frame = self.view.bounds;
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    
    [self initTestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
    [self refreshData];
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

- (void)initTestData
{
    if (_messageMArray == nil)
    {
        _messageMArray = [NSMutableArray array];
    }
    MessageData *messageData = [[MessageData alloc] init];
    messageData.messageTitle = @"来自系统消息";
    messageData.messageSummary = @"欢迎进入mySchool的大家庭";
    messageData.messageType = 0;
    [_messageMArray addObject:messageData];
    
    messageData = [[MessageData alloc] init];
    messageData.messageTitle = @"来自活动消息";
    messageData.messageSummary = @"小敏回复你的故居游评论";
    messageData.messageType = 1;
    [_messageMArray addObject:messageData];
    
    messageData = [[MessageData alloc] init];
    messageData.messageTitle = @"来自资讯消息";
    messageData.messageSummary = @"李晓回复你的针对国庆节放假通知评论";
    messageData.messageType = 2;
    [_messageMArray addObject:messageData];
    
    messageData = [[MessageData alloc] init];
    messageData.messageTitle = @"来自组织消息";
    messageData.messageSummary = @"李晓回复你的针对国庆节放假通知评论";
    messageData.messageType = 3;
    [_messageMArray addObject:messageData];
    
    messageData = [[MessageData alloc] init];
    messageData.messageTitle = @"来自求伴消息";
    messageData.messageSummary = @"网名回复你的打篮球活动";
    messageData.messageType = 4;
    [_messageMArray addObject:messageData];

}
#pragma mark BaseTableView
- (void)loadMorData
{
    
}

- (void)refreshData
{
    if (1)
    {
        [self.tableView reloadData];
    }
    else
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        __weak MyMessageViewController *weakSelf = self;
        [self requestDataWithAnalyseModel:[MessageModel class] params:dict success:^(id object)
         {
             /*成功返回数据*/
             MessageModel *model = object;
         }
                                     fail:^(id object)
         {
             /*失败返回数据*/
         }];
    }
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    return [self.messageMArray count];
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    MessageCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MessageData *messageData = [self.messageMArray objectAtIndex:indexPath.row];
    cell.messageData = messageData;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageData *messageData = [self.messageMArray objectAtIndex:indexPath.row];
    switch (messageData.messageType)
    {
        case 1:
        {
            [self pushCanvas:NSStringFromClass([ActivityDetailViewController class]) withArgument:nil];
        }
            break;
        case 2:
        {
            [self pushCanvas:NSStringFromClass([InfoDetailViewController class]) withArgument:nil];
        }
            break;
        case 3:
        {
            [self pushCanvas:NSStringFromClass([OrganizationDetailViewController class]) withArgument:nil];
        }
            break;
        case 4:
        {
            [self pushCanvas:NSStringFromClass([PartnerDetailViewController class]) withArgument:nil];
        }
            break;
        default:
            break;
    }
   
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MessageCell height];
}

@end
