//
//  WBRootViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/15.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBRootViewController.h"
#import "WBRootTabBar.h"

@interface WBRootViewController () <
    UINavigationControllerDelegate
>

@property (nonatomic, strong) NSArray *pageAry;
@property (nonatomic, strong) UIViewController *currentPage;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) WBRootTabBar *tabBar;

@end

@implementation WBRootViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setupPages];
  [self setupContentView];
  [self setupTabBar];

  [self showPageAtIndex:0];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  self.contentView.frame = self.view.bounds;
  _currentPage.view.frame = self.contentView.bounds;

  // 为了 Push 时候的动画效果，TabBar 可能会加入到 NavRoot 上，那时就不应该在此布局了
  if ( _tabBar.superview==self.view ) {
    _tabBar.frame = CGRectMake(0.0,
                               WB_SCREEN_HET-WB_SAFE_AREA_BOT-kWBRootTabBarHeight,
                               WB_SCREEN_WID,
                               WB_SAFE_AREA_BOT+kWBRootTabBarHeight);
  }
}

#pragma mark - Public methods

- (void)changeToPage:(NSUInteger)idx
{
  if ( [_tabBar isIndexValid:idx] ) {
    _tabBar.selectedIndex = idx;
    [self showPageAtIndex:idx];
    [self adjustTabBarSuperviewIfNeeded];
  }
}

#pragma mark - Private methods

- (void)showPageAtIndex:(NSUInteger)idx
{
  [(UINavigationController *)_currentPage setDelegate:nil];

  [self tk_dismissChildViewController:_currentPage];
  UIViewController *pageToShow = [_pageAry objectAtIndex:idx];
  [self tk_presentChildViewController:pageToShow inView:self.contentView];
  _currentPage = pageToShow;

  [(UINavigationController *)_currentPage setDelegate:self];
}

- (void)adjustTabBarSuperviewIfNeeded
{
  UINavigationController *nc = (UINavigationController *)_currentPage;
  if ( nc.viewControllers.count>1 ) {
    // 显示的是非根，TabBar 需要隐藏，且要位于 NavRoot 中
    WBBaseViewController *root = [nc.viewControllers firstObject];
    [self addTabBarToNavRootIfNeeded:root];
  } else {
    // 显示的是根，TabBar 不需要隐藏，且要位于 Root 中
    [self addTabBarToRootIfNeeded];
  }
}

- (void)addTabBarToNavRootIfNeeded:(WBBaseViewController *)root
{
  if ( _tabBar.superview!=root.toolBar ) {
    NSLog(@"add to nav root: %@", root);
    [_tabBar removeFromSuperview];
    [root.toolBar addSubview:_tabBar];
    _tabBar.frame = root.toolBar.bounds;
  }
}

- (void)addTabBarToRootIfNeeded
{
  if ( _tabBar.superview!=self.view ) {
    NSLog(@"add to root: %@", self);
    [_tabBar removeFromSuperview];
    [self.view addSubview:_tabBar];
    [self.view setNeedsLayout];
  }
}

#pragma mark - Setup subviews

- (void)setupPages
{
  _homeViewController = [[WBHomeViewController alloc] init];
  _homeViewController.hidesBottomBarWhenPushed = YES;
  UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:_homeViewController];
  nc1.navigationBarHidden = YES;

  _discoverViewController = [[WBDiscoverViewController alloc] init];
  _discoverViewController.hidesBottomBarWhenPushed = YES;
  UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:_discoverViewController];
  nc2.navigationBarHidden = YES;

  _messageViewController = [[WBMessageViewController alloc] init];
  _messageViewController.hidesBottomBarWhenPushed = YES;
  UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:_messageViewController];
  nc3.navigationBarHidden = YES;

  _profileViewController = [[WBProfileViewController alloc] init];
  _profileViewController.hidesBottomBarWhenPushed = YES;
  UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:_profileViewController];
  nc4.navigationBarHidden = YES;

  _pageAry = @[nc1, nc2, nc3, nc4];
}

- (void)setupContentView
{
  _contentView = [[UIView alloc] init];
  [self.view addSubview:_contentView];
}

- (void)setupTabBar
{
  @weakify(self);
  _tabBar = [[WBRootTabBar alloc] init];
  [self.view addSubview:_tabBar];
  _tabBar.didSelect = ^(NSUInteger idx) {
    @strongify(self);
    [self showPageAtIndex:idx];
    [self adjustTabBarSuperviewIfNeeded];
  };
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  //NSLog(@"will show: %@ %@", viewController, navigationController.viewControllers);
  WBBaseViewController *root = [navigationController.viewControllers firstObject];
  if ( root!=viewController ) {
    // 即将显示非根，如果 TabBar 不在 NavRoot 中，将其移过去，这样 TabBar 会随着 NavRoot 被 Push 隐藏
    [self addTabBarToNavRootIfNeeded:root];
  }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  //NSLog(@"did show: %@ %@", viewController, navigationController.viewControllers);
  WBBaseViewController *root = [navigationController.viewControllers firstObject];
  if ( root==viewController ) {
    // 已经显示根，如果 TabBar 不在 Root 中，将其移过来
    [self addTabBarToRootIfNeeded];
  }
}

@end
