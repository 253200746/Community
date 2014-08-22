//
//  PartnerDetailViewController.h
//  Community
//
//  Created by Andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseViewController.h"
#import "NeedPartnerListModel.h"

@interface PartnerDetailViewController : BaseViewController
@property (nonatomic,assign) BOOL fromLeftMenu;
@property (nonatomic,strong) PartnerData *partnerData;
@end
