//
//  SchooListViewController.m
//  Community
//
//  Created by Andy on 14-6-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "SchooListViewController.h"
#import "SchoolListModel.h"
#import "SchoolCell.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "LoginViewController.h"

#define SchoolListCount_Per_Page (20)

@interface SchooListViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *schoolMArray;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) NSArray *sectionTitles;
@end

@implementation SchooListViewController

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
    CGFloat nYOffset = 0;
    if (self.bRootViewController)
    {
        self.navigationItem.leftBarButtonItem = nil;
        _sectionTitles = [NSArray arrayWithObject:@"学校列表"];
    }
    else
    {
        _sectionTitles = [NSArray arrayWithObjects:@"我的学校",@"我正在看的学校",@"学校列表", nil];
    }
    
   
    self.title = @"请选择您所在学校";
    self.tableView.frame = CGRectMake(10, nYOffset,self.view.frame.size.width - 20, self.view.frame.size.height - 50);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self refreshData];
    
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
//    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = YES;
}

#pragma mark GetListData
- (void)getListData:(BOOL)refresh
{
    if (self.schoolMArray == nil)
    {
        _schoolMArray = [NSMutableArray array];
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (refresh)
    {
        [param setObject:@"0" forKey:@"lastNo"];
    }
    else
    {
        SchoolData *schoolData = [self.schoolMArray objectAtIndex:([self.schoolMArray count] - 1)];
        //最后一条活动的ID
        [param setObject:schoolData.schoolId forKey:@"lastNo"];
    }
    
    [param setObject:[NSString stringWithFormat:@"%d",SchoolListCount_Per_Page] forKey:@"pageSize"];
    
    __weak SchooListViewController *weakSelf = self;
    [self requestDataWithAnalyseModel:[SchoolListModel class] params:param success:^(id object)
     {
        /*成功返回数据*/
         __strong SchooListViewController *strongSelf = weakSelf;
         SchoolListModel *model = (SchoolListModel *)object;
         if (refresh)
         {
             [strongSelf.schoolMArray removeAllObjects];
         }
         [strongSelf.schoolMArray addObjectsFromArray:model.schoolMArray];
        
         if (refresh)
         {
             if ([model.schoolMArray count] == SchoolListCount_Per_Page)
             {
                 self.tableView.totalPage = 999;
             }
             else
             {
                 self.tableView.totalPage = 1;
             }
             
         }
         else
         {
             int nSchoolCount = [model.schoolMArray count];
             if (nSchoolCount < SchoolListCount_Per_Page)
             {
                 strongSelf.tableView.totalPage = [strongSelf.schoolMArray count] + (([strongSelf.schoolMArray count]% SchoolListCount_Per_Page)? 1 :0);
             }
         }
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
}

#pragma mark BaseTableView
- (void)loadMorData
{
    [self getListData:NO];
}

- (void)refreshData
{
    [self getListData:YES];
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return [self.sectionTitles count];
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    if (self.bRootViewController)
    {
        if (self.schoolMArray && [self.schoolMArray count] > 0)
        {
            return [self.schoolMArray count];
        }
    }
    else
    {
        if (section == 0)
        {
            return 1;
        }
        else if (section == 1)
        {
            return 1;
        }
        else
        {
            if (self.schoolMArray && [self.schoolMArray count] > 0)
            {
                return [self.schoolMArray count];
            }
        }
    }

    return 0;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *schoolCellIdentifier =  @"schoolCellIdentifier";
    static NSString *mySchoolCellIdentifier = @"mySchoolCellIdentifier";
    static NSString *currentSchoolCellIdentifier = @"currentSchoolCellIdentifier";
    UITableViewCell *cell = nil;
    if (self.bRootViewController)
    {
        SchoolCell *schoolCell = [baseTableCanvas dequeueReusableCellWithIdentifier:schoolCellIdentifier];
        if (schoolCell == nil)
        {
            schoolCell = [[SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:schoolCellIdentifier];
            schoolCell.contentView.backgroundColor = [UIColor clearColor];
            schoolCell.selectionStyle = UITableViewCellSelectionStyleNone;
            schoolCell.schoolCellType = 2;
        }
        
        if (self.schoolMArray && [self.schoolMArray count] > indexPath.row)
        {
            SchoolData *schoolData = [self.schoolMArray objectAtIndex:indexPath.row];
            schoolCell.schoolData = schoolData;
        }
        cell = schoolCell;
    }
    else
    {
        if (indexPath.section == 0)
        {
            SchoolCell *mySchoolCell = [baseTableCanvas dequeueReusableCellWithIdentifier:mySchoolCellIdentifier];
            if (mySchoolCell == nil)
            {
                mySchoolCell = [[SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mySchoolCellIdentifier];
                mySchoolCell.contentView.backgroundColor = [UIColor clearColor];
                mySchoolCell.selectionStyle = UITableViewCellSelectionStyleNone;
                mySchoolCell.schoolCellType = 0;
            }
            
            UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
            if (userInfo)
            {
                SchoolData *schoolData = [[SchoolData alloc] init];
                schoolData.schoolId = userInfo.schoolId;
                schoolData.name = userInfo.schoolName;
                mySchoolCell.schoolData = schoolData;
            }
            mySchoolCell.schoolData = nil;
            cell = mySchoolCell;
        }
        else if (indexPath.section == 1)
        {
            SchoolCell *currentSchoolCell = [baseTableCanvas dequeueReusableCellWithIdentifier:currentSchoolCellIdentifier];
            if (currentSchoolCell == nil)
            {
                currentSchoolCell = [[SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:currentSchoolCellIdentifier];
                currentSchoolCell.contentView.backgroundColor = [UIColor clearColor];
                currentSchoolCell.selectionStyle = UITableViewCellSelectionStyleNone;
                currentSchoolCell.schoolCellType = 1;
            }
           
            SchoolData *schoolData = [[SchoolData alloc] init];
            schoolData.schoolId = [AppInfo shareAppInfoManager].schoolId;
            schoolData.name = [AppInfo shareAppInfoManager].schoolName;
            currentSchoolCell.schoolData = schoolData;

            cell = currentSchoolCell;
        }
        else
        {
            SchoolCell *schoolCell = [baseTableCanvas dequeueReusableCellWithIdentifier:schoolCellIdentifier];
            if (schoolCell == nil)
            {
                schoolCell = [[SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:schoolCellIdentifier];
                schoolCell.contentView.backgroundColor = [UIColor clearColor];
                schoolCell.schoolCellType = 2;
            }
            
            if (self.schoolMArray && [self.schoolMArray count] > indexPath.row)
            {
                SchoolData *schoolData = [self.schoolMArray objectAtIndex:indexPath.row];
                schoolCell.schoolData = schoolData;
            }
            cell = schoolCell;

        }

    }
    return cell;
}

- (NSString *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitles objectAtIndex:section];
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bRootViewController)
    {
        SchoolData *schoolData = [self.schoolMArray objectAtIndex:indexPath.row];
        if (schoolData )
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:schoolData.schoolId forKey:@"schoolId"];
            [defaults setObject:schoolData.name forKey:@"schoolName"];
            [defaults synchronize];
            [AppInfo shareAppInfoManager].schoolId = schoolData.schoolId;
            [AppInfo shareAppInfoManager].schoolName = schoolData.name;
            
            if (self.bRootViewController)
            {
                [[AppDelegate shareAppDelegate] showHomeView];
            }
            return;
        }

    }
    if (indexPath.section == 0)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].userInfo;
        if (userInfo == nil)
        {
            self.hidesBottomBarWhenPushed = YES;
            [self pushCanvas:NSStringFromClass([LoginViewController class]) withArgument:nil];
            self.hidesBottomBarWhenPushed = NO;
        }
        else
        {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:userInfo.schoolId forKey:@"schoolId"];
            [defaults setObject:userInfo.name forKey:@"schoolName"];
            [defaults synchronize];
            
            [AppInfo shareAppInfoManager].schoolId = userInfo.schoolId;
            [AppInfo shareAppInfoManager].schoolName = userInfo.name;
            
            [self popCanvasWithArgment:nil];
        }
    }
    else if(indexPath.section == 1)
    {
        [self popCanvasWithArgment:nil];
    }
    else
    {
        SchoolData *schoolData = [self.schoolMArray objectAtIndex:indexPath.row];
        if (schoolData )
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:schoolData.schoolId forKey:@"schoolId"];
            [defaults setObject:schoolData.name forKey:@"schoolName"];
            [defaults synchronize];
            [AppInfo shareAppInfoManager].schoolId = schoolData.schoolId;
            [AppInfo shareAppInfoManager].schoolName = schoolData.name;
            
            if (self.bRootViewController)
            {
                [[AppDelegate shareAppDelegate] showHomeView];
            }
            else
            {
                [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:schoolData forKey:@"schoolData"]];
            }
        }

    }
        
   }

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bRootViewController)
    {
        return [SchoolCell height];
    }
    else
    {
        return 40.0f;
    }
    
}

@end
