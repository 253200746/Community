//
//  ActivityItemViewController.h
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseViewController.h"
#import "TypeModel.h"

@protocol ActivityItemViewControllerDelegate <NSObject>

- (void)didSelectectedItem:(NSString *)activityId;

@end

@interface ActivityItemViewController : BaseViewController
@property (nonatomic,assign) id<ActivityItemViewControllerDelegate> delegate;
@property (nonatomic,strong) TypeData *typeData;
@end