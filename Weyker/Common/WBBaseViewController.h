//
//  WBBaseViewController.h
//  GenericProj
//
//  Created by Kevin Wu on 12/29/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBBaseViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL viewAppeared;
@property (nonatomic, assign, readonly) BOOL appearedEver;

// 除开 NavBar 和 ToolBar 的区域
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UIView *toolBar;

- (void)disableContentInsetAdjustment:(UIScrollView *)scrollView;

// to override
- (BOOL)shouldLoadContentView;

@end
