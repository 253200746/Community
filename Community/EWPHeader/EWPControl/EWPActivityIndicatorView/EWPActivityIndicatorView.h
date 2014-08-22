//
//  EWPActivityIndicatorView.h
//  EWPActivityIndicatorView
//
//  Created by jiangbin on 13-11-19.
//  Copyright (c) 2013年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*指示器*/
@interface EWPActivityIndicatorView : UIView

@property (nonatomic,strong) NSString *promptTitle;

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

- (void)startAnimating;
- (void)stopAnimating;
@end
