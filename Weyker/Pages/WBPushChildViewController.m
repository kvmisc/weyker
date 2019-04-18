//
//  WBPushChildViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/18.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBPushChildViewController.h"

@interface WBPushChildViewController ()

@end

@implementation WBPushChildViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.contentView.backgroundColor = [UIColor brownColor];

  [self setupNavBar];
}

- (void)setupNavBar
{
  [super setupNavBar];

  static int count = 1;
  NSString *title = [NSString stringWithFormat:@"压%d", count];
  self.navBar.titleLabel.text = title;
  self.navigationItem.title = title;
  count++;

  [self.navBar.rightBtn setTitle:@"Present" forState:UIControlStateNormal];
}

- (void)navBarRightAction:(id)sender
{
  Class cls = NSClassFromString(@"WBPresentChildViewController");
  UIViewController *vc = [[cls alloc] init];
  UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
  nc.navigationBarHidden = YES;
  [self.navigationController presentViewController:nc animated:YES completion:NULL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  Class cls = NSClassFromString(@"WBPushChildViewController");
  UIViewController *vc = [[cls alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
