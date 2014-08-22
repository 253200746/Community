//
//  ActivityItemViewController.m
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityItemViewController.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import "UserInfoManager.h"
#import "SchooListViewController.h"
#import "AppInfo.h"
#import "ActivityDetailViewController.h"
#import "LoginViewController.h"

#define COUNT_PER_PAGE @"20"

@interface ActivityItemViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end

@implementation ActivityItemViewController

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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.typeData && self.typeData.typeId == 3)
    {
        if ([AppInfo shareAppInfoManager].bLoginSuccess)
        {
            [self refreshData];
        }
        else
        {
            [self showAlertView:nil message:@"未登录" confirm:nil cancel:nil];
        }
    }
    else
    {
        [self refreshData];
    }
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
        ActivityData *data = [self.dataMArray objectAtIndex:([self.dataMArray count] - 1)];
        [params setObject:data.activityId forKey:@"lastNo"];
    }
    else
    {
        [params setObject:@"0" forKey:@"lastNo"];
    }
    [params setObject:COUNT_PER_PAGE forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithInteger:self.typeData.typeId] forKey:@"type"];
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    [params setObject:@"0" forKey:@"inputId"];
    if (self.typeData.typeId == 3)
    {
        [params setObject:[UserInfoManager shareUserInfoManager].userInfo.userId forKey:@"inputId"];
    }
    __weak ActivityItemViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[ActivityModel class] params:params success:^(id object)
     {
         __strong ActivityItemViewController *strongSelf = weakSelf;
         /*成功返回数据*/
         ActivityModel *model = object;
         if (model)
         {
             [strongSelf.dataMArray addObjectsFromArray:model.dataMArray];
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
    [params setObject:COUNT_PER_PAGE forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithInteger:self.typeData.typeId] forKey:@"type"];
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    [params setObject:@"0" forKey:@"inputId"];
    if (self.typeData.typeId == 3)
    {
        [params setObject:[UserInfoManager shareUserInfoManager].userInfo.userId forKey:@"inputId"];
        [params setObject:[UserInfoManager shareUserInfoManager].userInfo.userId forKey:@"userId"];
    }
    else
    {
        [params setObject:@"0" forKey:@"inputId"];
    }
    __weak ActivityItemViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[ActivityModel class] params:params success:^(id object)
     {
         __strong ActivityItemViewController *strongSelf = weakSelf;
         /*成功返回数据*/
         ActivityModel *model = object;
         if ([model.resultCode isEqualToString:@"1"])
         {
             [strongSelf.dataMArray addObjectsFromArray:model.dataMArray];
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

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    if (self.dataMArray)
    {
        return [self.dataMArray count];
    }
    return 0;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    ActivityCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataMArray && [self.dataMArray count] > indexPath.row)
    {
        ActivityData *activityData = [self.dataMArray objectAtIndex:indexPath.row];
        cell.activityData = activityData;
    }
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.dataMArray && [self.dataMArray count] > 0)
//    {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectectedItem:)])
//        {
//           ActivityData *activityData = [self.dataMArray objectAtIndex:indexPath.row];
//            [self.delegate didSelectectedItem:activityData.activityId];
//        }
//    }
//    
//    
    ActivityData *activityData = [self.dataMArray objectAtIndex:indexPath.row];
    ActivityDetailViewController *viewController = [[ActivityDetailViewController alloc] init];
    viewController.activityId = activityData.activityId;
    [[AppDelegate shareAppDelegate].mainNavigationController pushViewController:viewController animated:YES];
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ActivityCell height];
}
@end
