//
//  WBHomeViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBRootToolBar.h"

@interface WBHomeViewController ()

@end

@implementation WBHomeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.contentView.backgroundColor = [UIColor lightGrayColor];

  [self setupNavBar];

  self.toolBar = [[WBRootToolBar alloc] init];
  [self.view addSubview:self.toolBar];
}

- (void)setupNavBar
{
  [super setupNavBar];

  [self.navBar setupTitleLabel];
  self.navBar.titleLabel.text = @"Home";

  [self.navBar setupRightBtn];
  [self.navBar.rightBtn setTitle:@"Home" forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  Class cls = NSClassFromString(@"WBTestViewController");
  UIViewController *vc = [[cls alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
