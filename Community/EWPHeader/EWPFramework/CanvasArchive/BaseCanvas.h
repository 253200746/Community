//
//  BaseCanvas.h
//  XiuBo
//
//  Created by Andy on 14-3-26.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IBaseCanvasProtocol <NSObject>

- (void)viewWillAppear;
- (void)viewwillDisappear;

- (void)initView:(CGRect)frame;

@end

@interface BaseCanvas : UIView<IBaseCanvasProtocol>

@property (nonatomic,strong) UIView *containerView;

- (id)initWithFrame:(CGRect)frame showInView:(UIView *)containerView;

- (void)viewWillAppear;
- (void)viewwillDisappear;
@end
