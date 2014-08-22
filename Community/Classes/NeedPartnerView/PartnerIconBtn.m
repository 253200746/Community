//
//  PartnerIconBtn.m
//  Community
//
//  Created by Andy on 14-7-27.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "PartnerIconBtn.h"

@implementation PartnerIconBtn


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(65, 0, contentRect.size.width-70, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(40, 9, 24, 21);
}

@end
