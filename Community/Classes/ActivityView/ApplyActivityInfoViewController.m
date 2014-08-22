//
//  ApplyActivityInfoViewController.m
//  Community
//
//  Created by andy on 14-8-22.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ApplyActivityInfoViewController.h"
#import "ApplyActivityInfoCell.h"
#import "ActivityAttendListModel.h"

@interface ApplyActivityInfoViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSMutableArray *applyActivityInfos;
@end

@implementation ApplyActivityInfoViewController

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
    self.title = @"报名信息";
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.refresh = NO;
    self.tableView.loadMore = NO;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
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

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSArray class]])
    {
        if (_applyActivityInfos == nil)
        {
            _applyActivityInfos = [NSMutableArray array];
        }
        [_applyActivityInfos removeAllObjects];
        [_applyActivityInfos addObjectsFromArray:argumentData];
    }
}
#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    if (self.applyActivityInfos)
    {
        int nCount = self.applyActivityInfos.count / 4 + ((self.applyActivityInfos.count % 4)? 1 : 0);
        return nCount;
    }
    
    return 1;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    ApplyActivityInfoCell *cell = [baseTableCanvas dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[ApplyActivityInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (self.applyActivityInfos )
    {
        NSMutableArray *tempMArray = [NSMutableArray array];
        int nIndex = indexPath.row * 4;
        int nCount = (self.applyActivityInfos.count - nIndex) >= 4? 4:(self.applyActivityInfos.count - nIndex);
        for (int i = 0; i < nCount; i++)
        {
            AttendPerson *data = [self.applyActivityInfos objectAtIndex:(nIndex + i)];
            [tempMArray addObject:data];
        }
        cell.applyActivityInfos = tempMArray;
    }
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ApplyActivityInfoCell height];
}
@end
