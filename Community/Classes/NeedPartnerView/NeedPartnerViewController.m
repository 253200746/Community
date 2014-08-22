//
//  NeedPartnerViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "NeedPartnerViewController.h"
#import "EWPTabMenuControl.h"
#import "PartnerItemViewController.h"
#import "PartnerDetailViewController.h"
#import "TypeModel.h"
#import "UserInfoManager.h"
#import "AppInfo.h"

@interface NeedPartnerViewController ()<EWPTabMenuControlDataSource,EWPTabMenuControlDelegate,PartnerItemViewControllerDelegate>

@property (nonatomic,strong) NSMutableDictionary *dataSoureDic;
@property (nonatomic,strong) EWPTabMenuControl *tabMenuControl;
@property (nonatomic,strong) NSMutableArray *typeMArray;
@end

@implementation NeedPartnerViewController

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
    self.title = @"求伴";

    _tabMenuControl = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40 -49)];
    _tabMenuControl.dataSource = self;
    _tabMenuControl.delegate = self;
    [self.view addSubview:_tabMenuControl];
    [self getTypeList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

    TypeModel *model = [[TypeModel alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //输入d
    [params setObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    [params setObject:@"partner" forKey:@"type"];
    [params setObject:@"0" forKey:@"lastNo"];
    [params setObject:@"999" forKey:@"pageSize"];
    [model requestDataWithParams:params success:^(id object) {
        if ([model.resultCode isEqualToString:@"1"])
        {
            [self.typeMArray addObjectsFromArray:model.typeMArray];
            [self.tabMenuControl reloadData];
        }
        else
        {
            [self showAlertView:nil message:model.message confirm:nil cancel:nil];
        }
    } fail:^(id object) {
        
    }];


    

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
    segmentedControl.frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
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
    PartnerItemViewController *itemViewController = [[PartnerItemViewController alloc] init];
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
        BOOL LeftMenuShowing = [[change objectForKey:@"LeftMenuShowing"] boolValue];
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

#pragma mark -PartnerItemViewControllerDelegate
- (void)didSelectectedItem:(PartnerData *)partnerData
{
    [self pushCanvas:NSStringFromClass([PartnerDetailViewController class]) withArgument:partnerData];
}
@end
