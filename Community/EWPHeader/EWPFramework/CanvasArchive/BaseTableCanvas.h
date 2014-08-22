//
//  BaseTableCanvas.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-12.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@class BaseTableCanvas;

@protocol BaseTableCanvasDataSoure <NSObject>

@required

- (NSInteger)numberOfSectionsInBaseTableCanvas:(BaseTableCanvas *)baseTableCanvas;

- (NSInteger)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (BOOL)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas titleForHeaderInSection:(NSInteger)section;
@end

@protocol BaseTableCanvasDelegate <NSObject>
@optional

- (NSIndexPath *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas willSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@required

- (void)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)baseTableCanvas:(BaseTableCanvas *)baseTableCanvas heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
/*上拉加载更多数据*/
- (void)loadMorData;

/*下拉刷新最新数据*/
- (void)refreshData;

@end


/*TableViewde的基类，包含上拉加载，下拉刷新，提示语*/
@interface BaseTableCanvas : UITableView<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>

/*当是类型为kbaseTableViewType时，子视图包含tableview，并且默认是支持上拉加载，下拉刷新*/
/*控制tableviewheader*/
@property (nonatomic,assign) BOOL refresh;
/*控制tableview foot*/
@property (nonatomic,assign) BOOL loadMore;

/*当前页*/
@property(nonatomic,assign) int curentPage;
/*总页数*/
@property(nonatomic,assign) int totalPage;

/*数据为空提示语*/
@property(nonatomic,strong) UILabel *tipContent;

@property(nonatomic,weak) id<BaseTableCanvasDataSoure> baseDataSource;
@property(nonatomic,weak) id<BaseTableCanvasDelegate>  baseDelegate;

- (void)free;

@end
