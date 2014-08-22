//
//  ICanvasProtocol.h
//  EWPProject
//
//  Created by jiangbin on 13-11-1.
//  Copyright (c) 2013年 woyipai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*Canvas接口*/
@class BaseCanvasController;

@protocol ICanvasProtocol <NSObject>

@required
/*传递到当前视图的参数函数*/
- (void)argumentForCanvas:(id)argumentData;
@optional

/*Canvas切换接口*/
- (BaseCanvasController *)pushCanvas:(NSString *) canvasName withArgument:(id)argumentData;
- (BaseCanvasController *)popCanvasWithArgment:(id)argument;
- (BaseCanvasController *)popToCanvas:(NSString *) canvasName withArgument:(id)argumentData;
- (BaseCanvasController *)popToRootCanvasWithArgment:(id)argumentData;

@end
