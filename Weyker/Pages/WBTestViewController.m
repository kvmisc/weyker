//
//  WBTestViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBTestViewController.h"
#import "WBRootViewController.h"
#import "WBTestNavView.h"

@implementation WBTestViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.contentView.backgroundColor = [UIColor brownColor];

  [self setupNavBar];

//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    UINavigationController *nc = (UINavigationController *)(WB_APP_DELEGATE.window.rootViewController);
//    WBRootViewController *root = [nc.viewControllers firstObject];
//    [root changeToPage:2];
//  });
}

- (void)setupNavBar
{
  [super setupNavBar];

  static int count = 1;
  NSString *title = [NSString stringWithFormat:@"测%d", count];
  self.navBar.titleLabel.text = title;
  self.navigationItem.title = title;
  count++;

  UIView *rightView = [[WBTestNavView alloc] init];
  [self.navBar setRightView:rightView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  Class cls = NSClassFromString(@"WBTestViewController");
  UIViewController *vc = [[cls alloc] init];
  [self.navigationController pushViewController:vc animated:YES];

//  static int count = 2;
//  if ( count<4 ) {
//    Class cls = NSClassFromString(@"WBTestViewController");
//    UIViewController *vc = [[cls alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    count++;
//  } else {
//    if ( self.navigationController.viewControllers.count==2 ) {
//      count=2;
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//  }
}

@end
