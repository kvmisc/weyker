//
//  WBBaseNavViewController.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBBaseViewController.h"

@interface WBBaseNavViewController : WBBaseViewController

// 如果左按钮不是返回或关闭，一定要在子类重写此方法，且不能调用 [super xxx];
- (void)navBarLeftAction:(id)sender;
- (void)navBarRightAction:(id)sender;

- (void)setNavBarLeftImage:(UIImage *)image;
- (void)setNavBarLeftTitle:(NSString *)title;
- (void)setNavBarTitle:(NSString *)title;
- (void)setNavBarRightImage:(UIImage *)image;
- (void)setNavBarRightTitle:(NSString *)title;

@end
