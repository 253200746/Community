//
//  OrganizationCell.h
//  Community
//
//  Created by Andy on 14-6-21.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrganizationModel.h"

@class OrganizationCell;
@protocol OrganizationCellDelegate <NSObject>

- (void)organizationCell:(OrganizationCell *)organizationCell didSelectWithAssociationId:(NSString *)associationId;

@end
@interface OrganizationCell : UITableViewCell

@property (nonatomic,strong) NSArray *organizationArray;
@property (nonatomic,assign) id<OrganizationCellDelegate> delegate;
+ (CGFloat)height;

@end
