//
//  OrganizationItemViewController.m
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "OrganizationItemViewController.h"
#import "OrganizationCell.h"
#import "OrganizationModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "OrganizationDetailViewController.h"

#define COUNT_PER_PAGE @"20"

@interface OrganizationItemViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate,OrganizationCellDelegate>
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end

@implementation OrganizationItemViewController

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
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 44);
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
        OrganizationData *data = [self.dataMArray objectAtIndex:([self.dataMArray count] - 1)];
        [params setObject:data.associationId forKey:@"lastNo"];
    }
    else
    {
        [params setObject:@"0" forKey:@"lastNo"];
    }
    [params setObject:COUNT_PER_PAGE forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithInteger:self.typeData.typeId] forKey:@"type"];
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    if (self.typeData.typeId == 3)
    {
        [params setObject:[UserInfoManager shareUserInfoManager].userInfo.userId forKey:@"userID"];
    }
    __weak OrganizationItemViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[OrganizationModel class] params:params success:^(id object)
     {
         __strong OrganizationItemViewController *strongSelf = weakSelf;
         /*成功返回数据*/
         OrganizationModel *model = object;
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
    [params setObject:[NSNumber numberWithInteger:self.typeData.typeId] forKey:@"typeId"];
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];

    __weak OrganizationItemViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[OrganizationModel class] params:params success:^(id object)
     {
         __strong OrganizationItemViewController *strongSelf = weakSelf;
         /*成功返回数据*/
         OrganizationModel *model = object;
         if ([model.resultCode isEqualToString:@"1"])
         {
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


#pragma mark - BaseTableCanvasDelegate

- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [OrganizationCell height];
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
        int nCount = self.dataMArray.count / 3 + ((self.dataMArray.count % 3)? 1 : 0);
        return nCount;
    }
    return 0;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    OrganizationCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[OrganizationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    if (self.dataMArray && [self.dataMArray count])
    {
        NSMutableArray *tempMArray = [NSMutableArray array];
        int nIndex = indexPath.row * 3;
        int nCount = (self.dataMArray.count - nIndex) >= 3? 3:(self.dataMArray.count - nIndex);
        for (int i = 0; i < nCount; i++)
        {
            OrganizationData *data = [self.dataMArray objectAtIndex:(nIndex + i)];
            [tempMArray addObject:data];
        }
        cell.organizationArray = tempMArray;
    }
    return cell;
}

#pragma mark - OrganizationCellDelegate

- (void)organizationCell:(OrganizationCell *)organizationCell didSelectWithAssociationId:(NSString *)associationId
{
    OrganizationDetailViewController *viewController = [[OrganizationDetailViewController alloc] init];
    viewController.associationId = associationId;
    [[AppDelegate shareAppDelegate].mainNavigationController pushViewController:viewController animated:YES];
}
@end
