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

  [self.navBar.rightBtn setTitle:@"下一个" forState:UIControlStateNormal];
}

- (void)navBarRightAction:(id)sender
{
  static int idx = 0;
  NSArray *languageAry = [WBLanguageManager availableLanguages];
  if ( idx>=languageAry.count ) { idx = 0; }
  NSDictionary *item = [languageAry objectAtIndex:idx];

  NSLog(@"before: %@", [WBLanguageManager currentLanguage]);
  NSLog(@"to: %@", item[@"code"]);
  [WBLanguageManager changeToLanguage:item[@"code"]];
  NSLog(@"become: %@", [WBLanguageManager currentLanguage]);

  idx++;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  NSLog(@"before: %@", [WBLanguageManager currentLanguage]);
  NSLog(@"to: default");
  [WBLanguageManager changeToSystemLanguage];
  NSLog(@"become: %@", [WBLanguageManager currentLanguage]);


//  Class cls = NSClassFromString(@"WBPushChildViewController");
//  UIViewController *vc = [[cls alloc] init];
//  [self.navigationController pushViewController:vc animated:YES];
}

@end
