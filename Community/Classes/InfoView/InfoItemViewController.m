//
//  InfoItemViewController.m
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "InfoItemViewController.h"
#import "InfoCell.h"
#import "AppInfo.h"
#import "NewsModel.h"
#import "InfoDetailViewController.h"

#define COUNT_PER_PAGE 20

@interface InfoItemViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end

@implementation InfoItemViewController

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
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    [self refreshData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark BaseTableView

- (void)loadMorData
{
    if (_dataMArray == nil)
    {
        _dataMArray = [NSMutableArray array];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.dataMArray && [self.dataMArray count] > 0)
    {
        NewsData *data = [self.dataMArray objectAtIndex:([self.dataMArray count] - 1)];
        [params setObject:data.newsId forKey:@"lastNo"];
    }
    else
    {
        [params setObject:@"0" forKey:@"lastNo"];
    }
    [params setObject:[NSString stringWithFormat:@"%d",COUNT_PER_PAGE] forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithInteger:self.typeData.typeId] forKey:@"type"];
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];

    __weak InfoItemViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[NewsModel class] params:params success:^(id object)
     {
         __strong InfoItemViewController *strongSelf = weakSelf;
         /*成功返回数据*/
         NewsModel *model = object;
         if (model)
         {
             [strongSelf.dataMArray addObjectsFromArray:model.dataMArray];
             if ([model.dataMArray count] < COUNT_PER_PAGE)
             {
                 strongSelf.tableView.totalPage = [strongSelf.dataMArray count] / COUNT_PER_PAGE + ([strongSelf.dataMArray count] % COUNT_PER_PAGE? 1 :0);
             }
             else
             {
                 strongSelf.tableView.totalPage = 999;
             }
             [strongSelf.tableView reloadData];
         }
     }
    fail:^(id object)
     {
         /*失败返回数据*/
     }];
    
}

- (void)refreshData
{
    if (_dataMArray == nil)
    {
        _dataMArray = [NSMutableArray array];
    }
    [_dataMArray removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"0" forKey:@"lastNo"];
    [params setObject:[NSString stringWithFormat:@"%d",COUNT_PER_PAGE] forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithInteger:self.typeData.typeId] forKey:@"newsTypeId"];
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    
    __weak InfoItemViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[NewsModel class] params:params success:^(id object)
     {
         __strong InfoItemViewController *strongSelf = weakSelf;
         /*成功返回数据*/
         NewsModel *model = object;
         if ([model.resultCode isEqualToString:@"1"])
         {
             [strongSelf.dataMArray addObjectsFromArray:model.dataMArray];
             if ([model.dataMArray count] < COUNT_PER_PAGE)
             {
                 strongSelf.tableView.totalPage = [strongSelf.dataMArray count] / COUNT_PER_PAGE + ([strongSelf.dataMArray count] % COUNT_PER_PAGE? 1 :0);
             }
             else
             {
                 strongSelf.tableView.totalPage = 999;
             }
             [strongSelf.tableView reloadData];
         }
         else
         {
//             [self showAlertView:nil message:model.message confirm:nil cancel:nil];
         }
     }
    fail:^(id object)
     {
         /*失败返回数据*/
     }];
}

#pragma mark - BaseTableCanvasDelegate

- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsData *newData = [self.dataMArray objectAtIndex:indexPath.row];
    InfoDetailViewController *infoDetailViewController = [[InfoDetailViewController alloc] init];
    infoDetailViewController.newsId = newData.newsId;
    [[AppDelegate shareAppDelegate].mainNavigationController pushViewController:infoDetailViewController animated:YES];
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InfoCell height];
}

#pragma BaseTableCanvaseDataSource
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    if (self.dataMArray && [self.dataMArray count])
    {
        return [self.dataMArray count];
    }
    return 0;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    InfoCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataMArray && [self.dataMArray count] > indexPath.row)
    {
        NewsData *newsData = [self.dataMArray objectAtIndex:indexPath.row];
        cell.newsData = newsData;
    }
    return cell;
}


@end
