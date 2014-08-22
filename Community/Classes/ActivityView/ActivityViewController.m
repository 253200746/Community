//
//  ActivityViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ActivityViewController.h"
#import "SchooListViewController.h"
#import "EWPTabMenuControl.h"
#import "ActivityItemViewController.h"
#import "TypeModel.h"
#import "UserInfoManager.h"
#import "AppInfo.h"
#import "ActivityDetailViewController.h"

@interface ActivityViewController ()<EWPTabMenuControlDataSource,EWPTabMenuControlDelegate,ActivityItemViewControllerDelegate>

@property (nonatomic,strong) EWPButton *schoolBtn;
@property (nonatomic,strong) EWPTabMenuControl *tabMenuControl;
@property (nonatomic,strong) NSMutableArray *typeMArray;

@end

@implementation ActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _schoolBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _schoolBtn.titleLabel.font = [UIFont systemFontOfSize:21.0f];
    _schoolBtn.frame = CGRectMake(100,12 , 120, 20);
    self.navigationItem.titleView = _schoolBtn;
    __weak ActivityViewController *weakSelf = self;
    _schoolBtn.buttonBlock = ^(id sender)
    {
        __strong ActivityViewController *strongSelf = weakSelf;
        SchooListViewController *viewController = [[SchooListViewController alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [strongSelf.navigationController pushViewController:viewController animated:YES];
        viewController.hidesBottomBarWhenPushed = NO;
    };

    _tabMenuControl = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40 - 49)];
    _tabMenuControl.dataSource = self;
    _tabMenuControl.delegate = self;
    [self.view addSubview:_tabMenuControl];
    [self getTypeList];
 }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [_schoolBtn setTitle:[AppInfo shareAppInfoManager].schoolName forState:UIControlStateNormal];
    [self setLeftMenu];
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController addObserver:self forKeyPath:@"LeftMenuShowing" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
     [[AppDelegate shareAppDelegate].lrSliderMenuViewController removeObserver:self forKeyPath:@"LeftMenuShowing"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GetType
- (void)getTypeList
{
    if (_typeMArray == nil)
    {
        _typeMArray = [NSMutableArray array];
    }
    [_typeMArray removeAllObjects];
    
    TypeData *typeData = [[TypeData alloc] init];
    typeData.typeId = 0;
    typeData.typeName = @"最热";
    [self.typeMArray addObject:typeData];
    
    typeData = [[TypeData alloc] init];
    typeData.typeId = 1;
    typeData.typeName = @"最新";
    [self.typeMArray addObject:typeData];
    
    typeData = [[TypeData alloc] init];
    typeData.typeId = 2;
    typeData.typeName = @"马上开始";
    [self.typeMArray addObject:typeData];
    
    typeData = [[TypeData alloc] init];
    typeData.typeId = 3;
    typeData.typeName = @"我的关注";
    [self.typeMArray addObject:typeData];
    
    self.tabMenuControl.defaultSelectedSegmentIndex = 0;
    [self.tabMenuControl reloadData];

}


#pragma mark - EWPTabMenuDataSource

- (EWPSegmentedControl *)ewpSegmentedControl
{
    NSMutableArray *titleArray = [NSMutableArray array];
    for (TypeData *typeData in self.typeMArray)
    {
        [titleArray addObject:typeData.typeName];
    }
    
    EWPSegmentedControl *segmentedControl = [[EWPSegmentedControl alloc] initWithSectionTitles:titleArray];
    segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.selectionStyle = EWPSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [CommonFuction colorFromHexRGB:@"55BB22"];
    segmentedControl.selectedTextColor = [CommonFuction colorFromHexRGB:@"55BB22"];
    segmentedControl.selectionIndicatorHeight = 3.0f;
    segmentedControl.font = [UIFont systemFontOfSize:17.0f];
    return segmentedControl;
}

- (UIViewController *)ewpTabMenuControl:(EWPTabMenuControl *)ewpTabMenuControl tabViewOfindex:(NSInteger)index
{
    TypeData *typeData = [self.typeMArray objectAtIndex:index];
    ActivityItemViewController *itemViewController = [[ActivityItemViewController alloc] init];
    itemViewController.delegate = self;
    itemViewController.typeData = typeData;
    return itemViewController;
}

#pragma mark - EWPTabMenuDelegate

- (void)progressEdgePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer tabMenuOfIndex:(NSInteger)index
{
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController moveViewWithGesture:panGestureRecognizer];
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"LeftMenuShowing"])
    {
        BOOL LeftMenuShowing = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (LeftMenuShowing)
        {
            [self.tabMenuControl ennableEwpTabMenu:NO];
        }
        else
        {
            [self.tabMenuControl ennableEwpTabMenu:YES];
        }
    }
}

#pragma mark -ActivityItemViewControllerDelegate
- (void)didSelectectedItem:(NSString *)activityId
{
     [self pushCanvas:NSStringFromClass([ActivityDetailViewController class]) withArgument:activityId];
}
@end
