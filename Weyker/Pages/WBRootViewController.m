//
//  WBRootViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/15.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBRootViewController.h"
#import "WBTimelineViewController.h"
#import "WBFindViewController.h"
#import "WBMessageViewController.h"
#import "WBMeViewController.h"

@interface WBRootViewController ()
@property (nonatomic, strong) UIView *tabBar;
@end

@implementation WBRootViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  _tabBar = [[UIView alloc] init];
  _tabBar.backgroundColor = [UIColor redColor];
  [self.view addSubview:_tabBar];

  self.contentView.backgroundColor = [UIColor greenColor];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  CGFloat tabBarHeight = 49.0;
  self.contentView.frame = CGRectMake(0.0, 0.0, WB_SCREEN_WID, WB_SCREEN_HET-WB_SAFE_AREA_BOT-tabBarHeight);
  _tabBar.frame = CGRectMake(0.0, WB_SCREEN_HET-WB_SAFE_AREA_BOT-tabBarHeight, WB_SCREEN_WID, tabBarHeight+WB_SAFE_AREA_BOT);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//  WBAuthorizeView *authorizeView = [[WBAuthorizeView alloc] init];
//  [authorizeView prepareForView:self.view viewport:nil];
//  [authorizeView.coverView show:YES];
//  [authorizeView startAuthorize:^(NSString *token) {
//    NSLog(@"%@", token);
//  }];
//}

@end
