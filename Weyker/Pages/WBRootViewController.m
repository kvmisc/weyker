//
//  WBRootViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/15.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBRootViewController.h"
#import "Common/WBAuthorizeView.h"

@implementation WBRootViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (BOOL)shouldLoadContentView
{
  return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  WBAuthorizeView *authorizeView = [[WBAuthorizeView alloc] init];
  [authorizeView prepareForView:self.view viewport:nil];
  [authorizeView.coverView show:YES];
  [authorizeView startAuthorize:^(NSString *token) {
    NSLog(@"%@", token);
  }];
}

@end
