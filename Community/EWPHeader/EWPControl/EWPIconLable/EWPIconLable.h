//
//  EWPIconLable.h
//  Community
//
//  Created by Andy on 14-6-25.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWPIconLable : UIView

@property (nonatomic,assign) CGFloat textSize;

@property (nonatomic,assign) CGFloat textXOffset;

- (id)initWithFrame:(CGRect)frame icon:(UIImage *)icon title:(NSString *)title;

- (void)SetTitle:(NSString *)title icon:(UIImage *)icon;
@end
