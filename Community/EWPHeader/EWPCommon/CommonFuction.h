//
//  CommonFuction.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-12.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonFuction : NSObject

/*返回字符串高度和宽度*/
+ (CGSize)sizeOfString:(NSString *)string withFontSize:(CGFloat)fontSize;

/*加了两个参数最大宽度和最大高度*/
+ (CGSize)sizeOfString:(NSString *)string maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight withFontSize:(CGFloat)fontSize;

/*返回document目录路径*/
+ (NSString *)documentPath;

+ (NSString *)dataToString:(NSData *)data;

+ (NSString *)uuid;

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (NSString *)getPlatformString;

@end
