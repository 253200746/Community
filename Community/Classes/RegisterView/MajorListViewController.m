//
//  MajorListViewController.m
//  Community
//
//  Created by Andy on 14-7-1.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "MajorListViewController.h"
#import "MajorListModel.h"
#import "UserInfoManager.h"
#import "SchoolListModel.h"

@interface MajorListViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *majorMArray;
@property (nonatomic,strong) InstituteData *instituteData;
@end

@implementation MajorListViewController

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
    self.title = @"请选择专业";
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 40);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.refresh = NO;
    self.loadMore = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self getListData];

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

#pragma mark GetListData
- (void)getListData
{
    if (self.majorMArray == nil)
    {
        _majorMArray = [NSMutableArray array];
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.instituteData.instituteId forKey:@"instituteId"];
    [param setObject:@"0" forKey:@"lastNo"];
    [param setObject:@"999" forKey:@"pageSize"];
    
    __weak MajorListViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[MajorListModel class] params:param success:^(id object)
     {
         /*成功返回数据*/
         __strong MajorListViewController *strongSelf = weakSelf;
         MajorListModel *model = (MajorListModel *)object;
         [strongSelf.majorMArray addObjectsFromArray:model.majorMArray];
         self.tableView.totalPage = 1;
         [strongSelf.tableView reloadData];
     }
    fail:^(id object)
     {
         /*失败返回数据*/
     }];
}
#pragma mark -baseViewController
- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *params = (NSDictionary *)argumentData;
        InstituteData *instituteData = [params objectForKey:@"instituteData"];
        if (instituteData)
        {
            self.instituteData = instituteData;
        }
    }
}


#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    if (self.majorMArray && [self.majorMArray count] > 0)
    {
        return [self.majorMArray count];
    }
    return 0;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    UITableViewCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    MajorData *majorData = [self.majorMArray objectAtIndex:indexPath.row];
    if (majorData)
    {
        cell.textLabel.text = majorData.name;
    }
   
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MajorData *majorData = [self.majorMArray objectAtIndex:indexPath.row];
    if (majorData)
    {
        [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:majorData forKey:@"majorData"]];
    }
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

@end
