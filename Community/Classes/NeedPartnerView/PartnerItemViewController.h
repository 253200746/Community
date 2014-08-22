//
//  PartnerItemViewController.h
//  Community
//
//  Created by Andy on 14-6-24.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseViewController.h"
#import "TypeModel.h"

@class PartnerData;
@protocol PartnerItemViewControllerDelegate <NSObject>

- (void)didSelectectedItem:(PartnerData *)partnerData;

@end

@interface PartnerItemViewController : BaseViewController
@property (nonatomic,assign) id<PartnerItemViewControllerDelegate> delegate;
@property (nonatomic,strong) TypeData *typeData;
@end
