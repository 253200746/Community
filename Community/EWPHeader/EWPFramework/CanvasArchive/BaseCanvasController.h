//
//  BaseCanvasController.h
//  EWPProject
//
//  Created by jiangbin on 13-11-1.
//  Copyright (c) 2013年 woyipai. All rights reserved.
//

#import "CanvasArchive.h"

#define Count_Per_Page (20)

typedef enum _BaseCanvasType
{
    kbaseViewType,
    kbaseScroolViewType,
    kbaseTableViewType,
}BaseCanvasType;

typedef void (^NavigationTouchButton)(id sender);

/*CanvasController的基类*/
@interface BaseCanvasController : UIViewController<ICanvasProtocol>

/*与系统parentView类似，但是这个手动设置上一级viewcontroller*/
@property (nonatomic,assign) BaseCanvasController *rootViewController;
/*默认类型是BaseViewType，是没有scrollview，此时scrollview为空*/
@property (nonatomic,assign) BaseCanvasType baseCanvasType;

/*如果基于scrollview的话，将内容加到scrollview，不需要手动创建*/
@property (nonatomic,strong) UIScrollView *scrollView;

/*如果子视图包含tableview的话，默认tableview的大小和view的大小一样，可以自己设置大小*/
@property (nonatomic,strong) BaseTableCanvas *tableView;
///*当是类型为kbaseTableViewType时，子视图包含tableview，并且默认是支持上拉加载，下拉刷新*/
@property (nonatomic,assign) BOOL refresh;
@property (nonatomic,assign) BOOL loadMore;



/*设置navigationcontroller左右按钮*/
- (void)setNavigationBarLeftItem:(NSString *) title itemNormalImg:(UIImage *)itemImg  itemHighlightImg:(UIImage *)highlightImg withBlock:(NavigationTouchButton) block;
- (void)setNavigationBarRightItem:(NSString *) title itemNormalImg:(UIImage *)itemImg  itemHighlightImg:(UIImage *)highlightImg withBlock:(NavigationTouchButton) block;

/*Canvas http请求数据接口*/
- (void)requestDataWithAnalyseModel:(Class )analyseModel params:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

/*AlertView*/
- (void)showAlertView:(NSString *)title message:(NSString *)message confirm:(AlertViewBlock)confirm cancel:(AlertViewBlock)cancel;

/*ActionSheetView*/
- (void)showActionSheetView:(NSString *)title buttonTitles:(NSArray *)buttonTitles actionSheetBlock:(ActionSheetBlock)actionSheetBlock;

@end