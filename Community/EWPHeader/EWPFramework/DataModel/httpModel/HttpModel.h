//
//  LogicModel.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpSerVerInterface.h"
#import "HttpModelProtocol.h"


/*数据源model逻辑模块，新增模块需要继承该类*/
@interface HttpModel : NSObject<HttpModelProtocol,HttpServerInterfaceProtocol>

@end
