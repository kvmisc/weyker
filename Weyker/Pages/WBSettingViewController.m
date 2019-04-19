//
//  WBSettingViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBSettingViewController.h"

@interface WBSettingViewController ()

@end

@implementation WBSettingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor brownColor];
  self.contentView.backgroundColor = [UIColor purpleColor];
}

- (void)setupNavBar
{
  [super setupNavBar];
  [self setNavBarTitle:WBLS(@"setting_navbar_title")];
}

@end
