//
//  WBRootViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/15.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBRootViewController.h"
#import "WBHomeViewController.h"
#import "WBDiscoverViewController.h"
#import "WBMessageViewController.h"
#import "WBProfileViewController.h"
#import "WBRootTabBar.h"

@interface WBRootViewController ()
@property (nonatomic, strong) WBRootTabBar *tabBar;
@end

@implementation WBRootViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  _tabBar = [[WBRootTabBar alloc] init];
  [self.view addSubview:_tabBar];

  self.contentView.backgroundColor = [UIColor greenColor];


  NSLog(@"%@", NSStringFromCGRect([[UIApplication sharedApplication] statusBarFrame]));
  UIScreen *screen = [UIScreen mainScreen];
  NSLog(@"%@ %@ %f %f", NSStringFromCGSize(screen.bounds.size),
        NSStringFromCGSize(screen.nativeBounds.size), screen.scale, screen.nativeScale);
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];

  self.contentView.frame = CGRectMake(0.0,
                                      0.0,
                                      WB_SCREEN_WID,
                                      WB_SCREEN_HET-WB_SAFE_AREA_BOT-kWBRootTabBarHeight);

  _tabBar.frame = CGRectMake(0.0,
                             WB_SCREEN_HET-WB_SAFE_AREA_BOT-kWBRootTabBarHeight,
                             WB_SCREEN_WID,
                             WB_SAFE_AREA_BOT+kWBRootTabBarHeight);
}

@end
