//
//  EWPTabMenuControl.h
//  Community
//
//  Created by Andy on 14-6-23.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseCanvas.h"
#import "EWPSegmentedControl.h"

@class EWPTabMenuControl;

@protocol EWPTabMenuControlDelegate <NSObject>

- (void)progressEdgePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer tabMenuOfIndex:(NSInteger)index;

@end

@protocol EWPTabMenuControlDataSource <NSObject>

- (EWPSegmentedControl *)ewpSegmentedControl;

- (UIViewController *)ewpTabMenuControl:(EWPTabMenuControl *)ewpTabMenuControl tabViewOfindex:(NSInteger)index;

@end

@interface EWPTabMenuControl : BaseCanvas

@property (nonatomic,assign) NSInteger defaultSelectedSegmentIndex;
@property (nonatomic,assign,getter = currentSelectedSegmentIndex) NSInteger currentSelectedSegmentIndex;
@property (nonatomic,assign) id<EWPTabMenuControlDelegate> delegate;
@property (nonatomic,assign) id<EWPTabMenuControlDataSource> dataSource;

- (void)reloadData;
- (void)ennableEwpTabMenu:(BOOL)enable;
@end
