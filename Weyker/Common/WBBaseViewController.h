//
//  WBBaseViewController.h
//  GenericProj
//
//  Created by Kevin Wu on 12/29/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBNavBar.h"
#import "WBToolBar.h"

@interface WBBaseViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL viewAppeared;
@property (nonatomic, assign, readonly) BOOL appearedEver;

// 除开 NavBar 和 ToolBar 的区域
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong) WBNavBar *navBar;
@property (nonatomic, strong) WBToolBar *toolBar;


- (void)setupNavBar;
- (void)setupToolBar;

- (BOOL)shouldLoadContentView;

- (void)disableContentInsetAdjustment:(UIScrollView *)scrollView;

@end
