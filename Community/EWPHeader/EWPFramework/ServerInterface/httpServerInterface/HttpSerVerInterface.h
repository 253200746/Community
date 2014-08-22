//
//  HttpSerVerInterface.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>


/*网络层基类，是基于第三方库AFNetWorking*/
@class HttpModel;

typedef void(^HttpServerInterfaceBlock)(id object);
@protocol HttpServerInterfaceProtocol <NSObject>

@required
/*请求数据*/

- (void)requestDataWithBaseUrl:(NSString *)baseUrl method:(NSString *)method httpHeader:(NSDictionary *)httpHeader httpBody:(NSDictionary *)httpBody success:(HttpServerInterfaceBlock) success fail:(HttpServerInterfaceBlock) fail;

@end

@interface HttpSerVerInterface : NSObject<HttpServerInterfaceProtocol>

+ (id)shareServerInterface;

@end
