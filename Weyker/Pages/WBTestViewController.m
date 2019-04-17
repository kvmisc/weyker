//
//  WBTestViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBTestViewController.h"
#import "WBRootViewController.h"

@implementation WBTestViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.contentView.backgroundColor = [UIColor brownColor];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    UINavigationController *nc = (UINavigationController *)(WB_APP_DELEGATE.window.rootViewController);
    WBRootViewController *root = [nc.viewControllers firstObject];
    [root changeToPage:2];
  });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  static int count = 2;
  if ( count<4 ) {
    Class cls = NSClassFromString(@"WBTestViewController");
    UIViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    count++;
  } else {
    if ( self.navigationController.viewControllers.count==2 ) {
      count=2;
    }
    [self.navigationController popViewControllerAnimated:YES];
  }
}

@end