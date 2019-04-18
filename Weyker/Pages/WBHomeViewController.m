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

@implementation WBHomeViewController {
  UIButton *_bt;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.contentView.backgroundColor = [UIColor lightGrayColor];

  [self setupNavBar];

  self.toolBar = [[WBRootToolBar alloc] init];
  [self.view addSubview:self.toolBar];

  UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
  _bt = bt;
  [self.contentView addSubview:bt];
  [bt mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.contentView);
  }];
}

- (void)setupNavBar
{
  [super setupNavBar];

  self.navBar.titleLabel.text = @"时间线";
  self.navigationItem.title = @"时间线";

  [self.navBar.rightBtn setTitle:@"注册" forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  Class cls = NSClassFromString(@"WBPushChildViewController");
  UIViewController *vc = [[cls alloc] init];
  [self.navigationController pushViewController:vc animated:YES];

//  AppDelegate *dlg = WB_APP_DELEGATE;
//  WBRootViewController *vc = dlg.window.rootViewController;
//  NSLog(@"%@ %@", vc.navigationController, vc.navigationItem.title);
}

@end
