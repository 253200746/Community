//
//  SchoolCell.h
//  Community
//
//  Created by Andy on 14-6-30.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SchoolListModel.h"

@interface DetailButton : UIButton

@end

@interface SchoolCell : UITableViewCell
@property (nonatomic,strong) SchoolData *schoolData;
@property (nonatomic,assign) NSInteger schoolCellType;//按照section顺序设置
+ (CGFloat)height;

@end
