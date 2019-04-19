//
//  WBBaseViewController.h
//  GenericProj
//
//  Created by Kevin Wu on 12/29/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBNavBar.h"

@interface WBBaseViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL viewAppeared;
@property (nonatomic, assign, readonly) BOOL appearedEver;

// 除开 NavBar 和 ToolBar 的区域
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong) WBNavBar *navBar;
@property (nonatomic, strong) UIView *toolBar;


- (void)setupNavBar;
- (void)navBarLeftAction:(id)sender; // 如果左按钮不是返回或关闭按钮，一定要在子类重写此方法，且不能调用 [super xxx];
- (void)navBarRightAction:(id)sender;

- (void)setupToolBar;

- (BOOL)shouldLoadContentView;

- (void)disableContentInsetAdjustment:(UIScrollView *)scrollView;

@end
