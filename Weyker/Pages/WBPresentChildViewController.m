//
//  WBPresentChildViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/18.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBPresentChildViewController.h"

@interface WBPresentChildViewController ()

@end

@implementation WBPresentChildViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.contentView.backgroundColor = [UIColor purpleColor];
}

- (void)setupNavBar
{
  [super setupNavBar];

  static int count = 1;
  NSString *title = [NSString stringWithFormat:@"推%d", count];
  self.navBar.titleLabel.text = title;
  self.navigationItem.title = title;
  count++;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  Class cls = NSClassFromString(@"WBPresentChildViewController");
  UIViewController *vc = [[cls alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
