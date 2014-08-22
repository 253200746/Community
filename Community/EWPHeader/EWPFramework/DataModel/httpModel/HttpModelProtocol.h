//
//  ModelProtocol.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpModelProtocol <NSObject>

@required
/*解析数据,每个model必须实现*/
- (BOOL)analyseData:(NSDictionary *)data;

/*请求数据*/
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock) success fail:(HttpServerInterfaceBlock) fail;

/*请求数据*/
- (void)requestDataWithMethod:(NSString *)method httpHeader:(NSDictionary *)httpHeader httpBody:(NSDictionary *)httpBody success:(HttpServerInterfaceBlock) success fail:(HttpServerInterfaceBlock) fail;

@end
