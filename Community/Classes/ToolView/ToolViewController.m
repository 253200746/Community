//
//  ToolViewController.m
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "ToolViewController.h"
#import "ToolListModel.h"
#import "AppInfo.h"
#import "UIButton+WebCache.h"
#import "ToolDetailViewController.h"

@interface ToolViewController ()
//暂时只按一个按钮代替，做完功能换掉tableviewcell，动态显示
@property (nonatomic,strong) EWPButton *btn;
@property (nonatomic,strong) NSMutableArray *toolMArray;
@end

@implementation ToolViewController

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
    self.title = @"应用";
    
    _btn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _btn.hidden = YES;
    _btn.frame = CGRectMake(10, 10, 70, 70);
    [self.view addSubview:_btn];
    __weak typeof(self) weakSelf = self;
    _btn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if ([strongSelf.toolMArray count])
        {
            ToolData *toolData = [strongSelf.toolMArray objectAtIndex:0];
            [strongSelf pushCanvas:NSStringFromClass([ToolDetailViewController class]) withArgument:toolData];
        }
    };
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLeftMenu];
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

- (void)getData
{
    NSDictionary *param = [NSDictionary dictionaryWithObject:[AppInfo shareAppInfoManager].schoolId forKey:@"schoolId"];
    [self requestDataWithAnalyseModel:[ToolListModel class] params:param success:^(id object) {
        ToolListModel *model = (ToolListModel *) object;
        if ([model.resultCode isEqualToString:@"1"])
        {
            if (_toolMArray == nil)
            {
                _toolMArray = [NSMutableArray array];
            }
            [_toolMArray removeAllObjects];
            
            [_toolMArray addObjectsFromArray:model.dataMArray];
            
            if ([model.dataMArray count])
            {
                ToolData *toolData = [self.toolMArray objectAtIndex:0];
                [self.btn setBackgroundImageWithURL:[NSURL URLWithString:toolData.img] forState:UIControlStateNormal];
                self.btn.hidden = NO;
            }
            
        }
    } fail:^(id object) {
        
    }];
}
@end
