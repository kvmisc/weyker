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

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSString *code = [WBLanguageManager currentLanguage];
    NSLog(@"before: %@", code);
    if ( [code hasPrefix:@"en"] ) {
      NSLog(@"to: %@", WB_LANGUAGE_CODE_ZH_HANS);
      [WBLanguageManager setLanguage:WB_LANGUAGE_CODE_ZH_HANS];
      NSLog(@"become: %@", [WBLanguageManager currentLanguage]);
    }
    if ( [code hasPrefix:@"zh"] ) {
      NSLog(@"to: %@", WB_LANGUAGE_CODE_EN);
      [WBLanguageManager setLanguage:WB_LANGUAGE_CODE_EN];
      NSLog(@"become: %@", [WBLanguageManager currentLanguage]);
    }
    NSLog(@" ");
    NSLog(@" ");
    NSLog(@" ");
  });
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
//  Class cls = NSClassFromString(@"WBPushChildViewController");
//  UIViewController *vc = [[cls alloc] init];
//  [self.navigationController pushViewController:vc animated:YES];

//  NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
//  NSLog(@"%@", language);
//
//  //[[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans-CN" forKey:@"AppleLanguages"];
//  //[[NSUserDefaults standardUserDefaults] setObject:@"en-CN" forKey:@"AppleLanguages"];
////  [[NSUserDefaults standardUserDefaults] setObject:@[@"en"] forKey:@"AppleLanguages"];
//  [[NSUserDefaults standardUserDefaults] setObject:@[@"zh-Hans"] forKey:@"AppleLanguages"];
//
//  language = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
//  NSLog(@"%@", language);

//  static int i=0;
//  ++i;
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    if ( i%2 ) {
//      [WBLanguageManager setLanguage:WB_LANGUAGE_CODE_EN];
//    } else {
//      [WBLanguageManager setLanguage:WB_LANGUAGE_CODE_ZH_HANS];
//    }
//  });




//  AppDelegate *dlg = WB_APP_DELEGATE;
//  WBRootViewController *vc = dlg.window.rootViewController;
//  NSLog(@"%@ %@", vc.navigationController, vc.navigationItem.title);
}

@end
