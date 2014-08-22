//
//  PartnerItemViewController.m
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerItemViewController.h"
#import "PartnerCell.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "NeedPartnerListModel.h"


#define COUNT_PER_PAGE @"20"

@interface PartnerItemViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end

@implementation PartnerItemViewController

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (void)viewWillLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*上拉加载更多数据*/
- (void)refreshData
{
    if (_dataMArray == nil)
    {
        _dataMArray = [NSMutableArray array];
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    [params setObject:@"0" forKey:@"visitId"];
    [params setObject:[NSString stringWithFormat:@"%d",self.typeData.typeId] forKey:@"typeId"];
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
//             [self showAlertView:nil message:model.message confirm:nil cancel:nil];
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
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    [params setObject:[UserInfoManager shareUserInfoManager].userInfo.userId forKey:@"userId"];
    [params setObject:[NSString stringWithFormat:@"%d",self.typeData.typeId] forKey:@"typeId"];


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
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectectedItem:)])
        {
            PartnerData *partnerData = [self.dataMArray objectAtIndex:indexPath.row];
            [self.delegate didSelectectedItem:partnerData];
        }
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
