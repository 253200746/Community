//
//  SexViewController.m
//  Community
//
//  Created by Andy on 14-7-3.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "SexViewController.h"

@interface SexViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) NSArray *array;
@end

@implementation SexViewController

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
    self.title = @"请选择性别";
    _array = [NSArray arrayWithObjects:@"男",@"女", nil];
    
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 40);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.loadMore = NO;
    self.refresh = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
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
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:indexPath.row] forKey:@"Sex"]];
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

@end
