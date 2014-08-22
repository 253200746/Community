//
//  PartnerDetailViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerDetailViewController.h"
#import "PartnerDetailModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "PartnerCell.h"
#import "PartnerLikeListModel.h"
#import "PartnerCommentListModel.h"
#import "MBProgressHUD.h"
#import "PartnerFansCell.h"
#import "PartnerCommentCell.h"

#define CommentCount_Per_Page @"20"

@interface PartnerDetailViewController ()<BaseTableCanvasDataSoure,BaseTableCanvasDelegate,UITextFieldDelegate>
@property (nonatomic,strong) MBProgressHUD *mbProgressHud;

@property (nonatomic,strong) NSMutableArray *likeFansList;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) NSMutableArray *partnerCommentList;
@property (nonatomic,strong) UITextField *textField;
@end

@implementation PartnerDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseCanvasType = kbaseTableViewType;
        self.fromLeftMenu = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"求伴详情";
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height - 84);
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 82, self.view.frame.size.width,1)];
    lineImg.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineImg];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 78, 300, 30)];
    _textField.delegate = self;
    _textField.placeholder = @"回复活动";
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textField.layer.cornerRadius = 5.0f;
    [self.view addSubview:_textField];
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.fromLeftMenu)
    {
        [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = NO;
    }
    else
    {
         self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.fromLeftMenu)
    {
        [AppDelegate shareAppDelegate].mainNavigationController.navigationBarHidden = YES;
    }
    else
    {
        self.tabBarController.tabBar.hidden = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[PartnerData class]])
    {
        self.partnerData = argumentData;
    }
}

#pragma mark - 获取数据
- (void)getData
{
    if (self.partnerData)
    {
        _mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_mbProgressHud];
        [_mbProgressHud show:YES];
        
        [self getPartnerLikeList];
        [self getPartnerCommentList];
    }
}

#pragma mark - 获取求伴喜欢列表
- (void)getPartnerLikeList
{
    PartnerLikeListModel *model = [[PartnerLikeListModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:self.partnerData.partnerId forKey:@"partnerId"];
    [model requestDataWithParams:param success:^(id object) {
        if ([model.resultCode isEqualToString:@"1"])
        {
            if (_likeFansList == nil)
            {
                _likeFansList = [NSMutableArray array];
            }
            [_likeFansList removeAllObjects];
            
            [self.likeFansList addObjectsFromArray:model.dataMArray];
            if (self.partnerCommentList)
            {
                [self.mbProgressHud hide:YES];
                [self.tableView reloadData];
            }
        }
    } fail:^(id object) {
        
    }];
}

#pragma mark - 获取求伴评论列表
- (void)getPartnerCommentList
{
    PartnerCommentListModel *model = [[PartnerCommentListModel alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.partnerData.partnerId forKey:@"partnerId"];
    [params setObject:@"0" forKey:@"lastNo"];
    [params setObject:CommentCount_Per_Page forKey:@"pageSize"];
    
    [model requestDataWithParams:params success:^(id object) {
        if ([model.resultCode isEqualToString:@"1"])
        {
            if (_partnerCommentList == nil)
            {
                _partnerCommentList = [NSMutableArray array];
            }
            [_partnerCommentList removeAllObjects];
            
            [self.partnerCommentList addObjectsFromArray:model.dataMArray];
            if (self.likeFansList)
            {
                [self.mbProgressHud hide:YES];
                [self.tableView reloadData];
            }
        }
    } fail:^(id object) {
        
    }];
}

#pragma mark BaseTableView
- (void)loadMorData
{
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas
{
    return 1;
}

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 1;
    if (self.likeFansList && [self.likeFansList count])
    {
        number += 1;
    }
    
    if (self.partnerCommentList && [self.partnerCommentList count])
    {
        number += [self.partnerCommentList count];
    }
    return number;
}

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *partnerCellIdentifier =  @"PartnerCellIdentifier";
    static NSString *partnerLikeCellIdentifier = @"PartnerLikeCellIdentifier";
    static NSString *partnerCommentCellIdentifier = @"PartnerCommentCellIdentifier";
    UITableViewCell *cell = nil;
    if (indexPath.row == 0)
    {
        PartnerCell *partnerCell = [baseTableCanvas dequeueReusableCellWithIdentifier:partnerCellIdentifier];
        if (partnerCell == nil)
        {
            partnerCell = [[PartnerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:partnerCellIdentifier];
            partnerCell.contentView.backgroundColor = [UIColor clearColor];
            partnerCell.backgroundColor = [UIColor clearColor];
            partnerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        partnerCell.bShowDetailParnter = YES;
        partnerCell.partnerData = self.partnerData;
        cell = partnerCell;
    }
    else if (indexPath.row == 1)
    {
        if (self.likeFansList && [self.likeFansList count])
        {
            //喜欢的
            PartnerFansCell *partnerFansCell = [baseTableCanvas dequeueReusableCellWithIdentifier:partnerLikeCellIdentifier];
            if (partnerFansCell == nil)
            {
                partnerFansCell = [[PartnerFansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:partnerLikeCellIdentifier];
                partnerFansCell.contentView.backgroundColor = [UIColor clearColor];
                partnerFansCell.backgroundColor = [UIColor clearColor];
                partnerFansCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            partnerFansCell.likeFansList = self.likeFansList;
            cell = partnerFansCell;

        }
        else
        {
            //评论
            PartnerCommentCell *partnerCommentCell = [baseTableCanvas dequeueReusableCellWithIdentifier:partnerCommentCellIdentifier];
            if (partnerCommentCell == nil)
            {
                partnerCommentCell = [[PartnerCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:partnerCommentCellIdentifier];
                partnerCommentCell.contentView.backgroundColor = [UIColor clearColor];
                partnerCommentCell.backgroundColor = [UIColor clearColor];
                partnerCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSInteger index = indexPath.row - 1;
            PartnerCommentData *partnerCommentData = [self.partnerCommentList objectAtIndex:index];
            partnerCommentCell.partnerCommentData = partnerCommentData;
            cell = partnerCommentCell;
        }
    }
    else
    {
        //评论
        PartnerCommentCell *partnerCommentCell = [baseTableCanvas dequeueReusableCellWithIdentifier:partnerCommentCellIdentifier];
        if (partnerCommentCell == nil)
        {
            partnerCommentCell = [[PartnerCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:partnerCommentCellIdentifier];
            partnerCommentCell.contentView.backgroundColor = [UIColor clearColor];
            partnerCommentCell.backgroundColor = [UIColor clearColor];
            partnerCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSInteger index = indexPath.row - 1;
        PartnerCommentData *partnerCommentData = [self.partnerCommentList objectAtIndex:index];
        partnerCommentCell.partnerCommentData = partnerCommentData;
        cell = partnerCommentCell;
        
    }

    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [PartnerCell height] - 40;
    }
    else if(indexPath.row == 1)
    {
        if (self.likeFansList && [self.likeFansList count])
        {
            return [PartnerFansCell height];
        }
        else
        {
            NSInteger index = indexPath.row - 1;
            PartnerCommentData *partnerCommentData = [self.partnerCommentList objectAtIndex:index];
            CGSize size = [CommonFuction sizeOfString:partnerCommentData.commentContent maxWidth:280 maxHeight:1000 withFontSize:13.0f];
            return [PartnerCommentCell height] + size.height;

        }
    }
    else
    {
        NSInteger index = indexPath.row - 1;
        PartnerCommentData *partnerCommentData = [self.partnerCommentList objectAtIndex:index];
        CGSize size = [CommonFuction sizeOfString:partnerCommentData.commentContent maxWidth:280 maxHeight:1000 withFontSize:13.0f];
        return [PartnerCommentCell height] + size.height;
    }
    return 0;
}

@end
