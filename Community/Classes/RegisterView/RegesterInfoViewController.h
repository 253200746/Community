//
//  RegesterInfoViewController.h
//  Community
//
//  Created by Andy on 14-6-22.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseViewController.h"

@interface RegesterInfoViewController : BaseViewController
@property (nonatomic,strong) UIImageView *photoView;
@property (nonatomic,strong) UITextField *name;
@property (nonatomic,strong) UITextField *userName;//用户名
@property (nonatomic,strong) UITextField *nickName;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *confirmPassword;
@property (nonatomic,strong) EWPButton *schoolBtn;//所在学校
@property (nonatomic,strong) EWPButton *collegeBtn;//所在学院
@property (nonatomic,strong) EWPButton *majorBtn;//所学专业
@property (nonatomic,strong) EWPButton *starYearBtn;//入学年份
@property (nonatomic,strong) UITextField *studentId;//学号
@property (nonatomic,strong) EWPButton *sexBtn;//性别
@end
