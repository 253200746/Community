//
//  ChangeSchoolViewController.m
//  Community
//
//  Created by Andy on 14-6-20.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ChangeSchoolViewController.h"

@interface ChangeSchoolViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate>
@property (nonatomic,strong) BaseTableCanvas *schoolTableView;
@property (nonatomic,strong) NSMutableArray *dataMArray;
@end

@implementation ChangeSchoolViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataMArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"请选择您所在的学校";
    self.navigationItem.leftBarButtonItem = nil;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    lable.font = [UIFont systemFontOfSize:14.0f];
    lable.text = @"学校列表";
    [self.view addSubview:lable];
    
    _schoolTableView = [[BaseTableCanvas alloc] initWithFrame:CGRectMake(10, 30, 300, SCREEN_HEIGHT - 120) style:UITableViewStylePlain];
    _schoolTableView.baseDataSource = self;
    _schoolTableView.baseDelegate = self;
    [self.view addSubview:_schoolTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - BaseTableCanvasDataSoure

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
    return nil;
}

#pragma mark-BaseTableCanvasDelegate

- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

@end
