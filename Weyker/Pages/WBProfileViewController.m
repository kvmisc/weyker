//
//  WBProfileViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBProfileViewController.h"
#import "WBRootToolBar.h"

@interface WBProfileViewController ()

@end

@implementation WBProfileViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.contentView.backgroundColor = [UIColor blueColor];
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
