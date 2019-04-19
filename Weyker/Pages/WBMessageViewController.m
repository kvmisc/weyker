//
//  WBMessageViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/16.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBMessageViewController.h"
#import "WBRootToolBar.h"

@interface WBMessageViewController ()

@end

@implementation WBMessageViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.contentView.backgroundColor = [UIColor greenColor];
}

- (void)setupToolBar
{
  self.toolBar = [[WBRootToolBar alloc] init];
  [self.view addSubview:self.toolBar];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  Class cls = NSClassFromString(@"WBTestViewController");
  UIViewController *vc = [[cls alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
