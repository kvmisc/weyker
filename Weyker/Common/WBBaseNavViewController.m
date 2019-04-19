//
//  WBBaseNavViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBBaseNavViewController.h"

@interface WBBaseNavViewController ()

@end

@implementation WBBaseNavViewController

- (void)setupNavBar
{
  if ( !self.navBar ) {
    self.navBar = [[WBNavBar alloc] init];
    [self.navBar.leftBtn addTarget:self
                            action:@selector(navBarLeftAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.navBar.rightBtn addTarget:self
                             action:@selector(navBarRightAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navBar];
  }
  [self setupNavBarBackIfNeeded];
}
- (void)setupNavBarBackIfNeeded
{
  if ( self.navigationController ) {
    NSArray *controllerAry = self.navigationController.viewControllers;
    NSUInteger idx = [controllerAry indexOfObjectIdenticalTo:self];
    if ( idx<controllerAry.count ) {
      // 处于导航中
      if ( idx==0 ) {
        // 是导航的根，检查导航是否被 Present，决定是否显示 Close 按钮
        if ( self.navigationController.presentingViewController ) {
          [self.navBar setupDismissBtn];
        }
      } else {
        // 非导航的根，要显示返回按钮
        [(WBNavBar *)(self.navBar) setupPopBtn];
        // 取到前一个 ViewController，再取出里面的标题，如果标题太长，将标题压缩，显示
        UIViewController *controller = [controllerAry objectAtIndex:idx-1];
        NSString *title = [WBNavBar truncateText:controller.navigationItem.title toLength:2];
        if ( title.length>0 ) {
          [self.navBar.leftBtn setTitle:title forState:UIControlStateNormal];
        }
      }
    }
  } else {
    // 不在导航中，检查是否被 Present，决定是否显示 Close 按钮
    if ( self.presentingViewController ) {
      [self.navBar setupDismissBtn];
    } else {
    }
  }
}
- (void)navBarLeftAction:(id)sender
{
  if ( self.navigationController ) {
    NSArray *controllerAry = self.navigationController.viewControllers;
    NSUInteger idx = [controllerAry indexOfObjectIdenticalTo:self];
    if ( idx<controllerAry.count ) {
      // 处于导航中
      if ( idx==0 ) {
        // 是导航的根，检查导航是否被 Present，决定是否 Dismiss
        if ( self.navigationController.presentingViewController ) {
          [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }
      } else {
        // 非导航的根，Pop
        [self.navigationController popViewControllerAnimated:YES];
      }
    }
  } else {
    // 不在导航中，检查是否被 Present，决定是否 Dismiss
    if ( self.presentingViewController ) {
      [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
    }
  }
}
- (void)navBarRightAction:(id)sender
{
}

@end
