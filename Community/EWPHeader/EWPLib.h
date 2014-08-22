//
//  EWPLib.h
//  EWPLib
//
//  Created by andy on 14-7-21.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroMethod.h"
//#import "Constants.h"
//#import "ServerMethod.h"
#import "MacroMethod.h"
//#import "CanvasType.h"

#import "CommonFuction.h"
//#import "AppInfo.h"

@interface EWPLib : NSObject
+ (instancetype)shareInstance;
- (instancetype)initWithPrivateKey:(NSString *)privateKey;
@end
