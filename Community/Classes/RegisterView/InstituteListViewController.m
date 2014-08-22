//
//  InstituteListViewController.m
//  Community
//
//  Created by Andy on 14-7-1.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "InstituteListViewController.h"
#import "InstituteListModel.h"
#import "UserInfo.h"

@interface InstituteListViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *instituteMArray;
@property (nonatomic,strong) SchoolData *schoolData;
@end

@implementation InstituteListViewController

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
    self.title = @"请选择学院";
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
    if (self.instituteMArray == nil)
    {
        _instituteMArray = [NSMutableArray array];
    }
    [_instituteMArray removeAllObjects];
    if (self.schoolData && self.schoolData.instituteMArray && [self.schoolData.instituteMArray count])
    {
        [self.instituteMArray addObjectsFromArray:self.schoolData.instituteMArray];
        [self.tableView reloadData];
    }
}
#pragma mark -baseViewController
- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData)
    {
        self.schoolData = argumentData;
    }
}


#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    if (self.instituteMArray && [self.instituteMArray count] > 0)
    {
        return [self.instituteMArray count];
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
    InstituteData *instituteData = [self.instituteMArray objectAtIndex:indexPath.row];
    if (instituteData)
    {
        cell.textLabel.text = instituteData.name;
    }

    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InstituteData *instituteData = [self.instituteMArray objectAtIndex:indexPath.row];
    if (instituteData)
    {
        [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:instituteData forKey:@"instituteData"]];
    }
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}



@end
