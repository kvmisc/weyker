//
//  WBBaseViewController.m
//  GenericProj
//
//  Created by Kevin Wu on 12/29/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

#import "WBBaseViewController.h"

@implementation WBBaseViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self loadContentViewIfNeeded];
  [self setupNavBar];
  [self setupToolBar];
}
- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  _viewAppeared = YES;
}
- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  _viewAppeared = NO;
  _appearedEver = YES;
}
- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];

  CGFloat topSpacing = 0.0;
  if ( _navBar ) {
    CGSize navSize = [_navBar intrinsicContentSize];
    topSpacing = WB_STATUS_BAR_HET+navSize.height;
    _navBar.frame = CGRectMake(0.0,
                               0.0,
                               WB_SCREEN_WID,
                               WB_STATUS_BAR_HET+navSize.height);
  }

  CGFloat bottomSpacing = WB_SAFE_AREA_BOT;
  if ( _toolBar ) {
    CGSize toolSize = [_toolBar intrinsicContentSize];
    bottomSpacing = toolSize.height+WB_SAFE_AREA_BOT;
    _toolBar.frame = CGRectMake(0.0,
                                WB_SCREEN_HET-toolSize.height-WB_SAFE_AREA_BOT,
                                WB_SCREEN_WID,
                                toolSize.height+WB_SAFE_AREA_BOT);
  }

  _contentView.frame = CGRectMake(0.0,
                                  topSpacing,
                                  WB_SCREEN_WID,
                                  WB_SCREEN_HET-topSpacing-bottomSpacing);
}


#pragma mark - Public methods

- (void)setupNavBar
{
}

- (void)setupToolBar
{
}

- (BOOL)shouldLoadContentView
{
  return YES;
}

- (void)disableContentInsetAdjustment:(UIScrollView *)scrollView
{
  if ( @available(iOS 11.0, *) ) {
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
}


#pragma mark - Private methods

- (void)loadContentViewIfNeeded
{
  if ( _contentView ) { return; }

  if ( [self shouldLoadContentView] ) {
    _contentView = [self.view.subviews firstObject];
    if ( _contentView ) {
      // 删除视图再添加可以让 XIB 中添加的约束消失，这样就可以在代码中约束
      // 但是不清楚删除视图再添加会不会造成什么潜在的问题，所以还是决定不删除
      // 如果不删除，开发的时候在 XIB 中添加的约束应设置为 remove at build time
      //[_contentView removeFromSuperview];
      //[self.view insertSubview:_contentView atIndex:0];
    } else {
      _contentView = [[UIView alloc] init];
      [self.view addSubview:_contentView];
    }
  }
}

@end
