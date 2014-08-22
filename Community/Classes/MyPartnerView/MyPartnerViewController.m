//
//  MyPartnerViewController.m
//  Community
//
//  Created by Andy on 14-6-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MyPartnerViewController.h"
#import "PartnerCell.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "NeedPartnerListModel.h"
#import "PartnerDetailViewController.h"

#define COUNT_PER_PAGE @"20"

@interface MyPartnerViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end

@implementation MyPartnerViewController

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
    self.title = @"我的求伴";
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.refresh = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self refreshData];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
}

/*上拉加载更多数据*/
- (void)refreshData
{
    if (_dataMArray == nil)
    {
        _dataMArray = [NSMutableArray array];
    }
    
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userInfo.schoolId forKey:@"schoolId"];
    [params setObject:userInfo.userId forKey:@"sendUserId"];
    [params setObject:@"0" forKey:@"lastNo"];
    [params setObject:COUNT_PER_PAGE forKey:@"pageSize"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[NeedPartnerListModel class] params:params success:^(id object)
     {
         __strong typeof(self) strongSelf = weakSelf;
         /*成功返回数据*/
         NeedPartnerListModel *model = object;
         if ([model.resultCode isEqualToString:@"1"])
         {
             [strongSelf.dataMArray removeAllObjects];
             [strongSelf.dataMArray addObjectsFromArray:model.dataMArray];
             [strongSelf.tableView reloadData];
         }
         else
         {
             [self showAlertView:nil message:model.message confirm:nil cancel:nil];
         }
     }
                                 fail:^(id object)
     {
         /*失败返回数据*/
     }];
    
}


/*下拉刷新最新数据*/
- (void)loadMorData
{
    if (_dataMArray == nil)
    {
        _dataMArray = [NSMutableArray array];
    }
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.dataMArray && [self.dataMArray count] > 0)
    {
        PartnerData *data = [self.dataMArray objectAtIndex:([self.dataMArray count] - 1)];
        [params setObject:data.partnerId forKey:@"lastNo"];
    }
    else
    {
        [params setObject:@"0" forKey:@"lastNo"];
    }
    [params setObject:COUNT_PER_PAGE forKey:@"pageSize"];
    [params setObject:userInfo.schoolId forKey:@"schoolId"];
     [params setObject:userInfo.userId forKey:@"sendUserId"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[NeedPartnerListModel class] params:params success:^(id object)
     {
         __strong typeof(self) strongSelf = weakSelf;
         /*成功返回数据*/
         NeedPartnerListModel *model = object;
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

#pragma mark - BaseTableCanvasDelegate

- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataMArray && [self.dataMArray count] > 0)
    {
        PartnerData *partnerData = [self.dataMArray objectAtIndex:indexPath.row];
        PartnerDetailViewController *viewController = [[PartnerDetailViewController alloc] init];
        viewController.partnerData = partnerData;
        viewController.fromLeftMenu = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [PartnerCell height];
    if (self.dataMArray && [self.dataMArray count])
    {
        PartnerData *partnerData = [self.dataMArray objectAtIndex:indexPath.row];
        if (partnerData && partnerData.imgurl && [partnerData.imgurl length] > 0)
        {
            height += 150;
        }
        
        if (partnerData && partnerData.commentNum && [partnerData.commentNum integerValue]> 0)
        {
            height += 70;
        }
    }
    return [PartnerCell height];
}

#pragma BaseTableCanvaseDataSource
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    return [self.dataMArray count];
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    PartnerCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[PartnerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataMArray && [self.dataMArray count] > indexPath.row)
    {
        PartnerData *partnerData = [self.dataMArray objectAtIndex:indexPath.row];
        cell.partnerData = partnerData;
    }
    return cell;
    
}

@end
