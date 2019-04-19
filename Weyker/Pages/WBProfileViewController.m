//
//  WBProfileViewController.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBProfileViewController.h"
#import "WBRootToolBar.h"

#import "WBProfileDataSource.h"

#import "WBSettingViewController.h"

@interface WBProfileViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WBTableViewDataSource *dataSource;
@end

@implementation WBProfileViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setupTableView];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  _tableView.frame = self.contentView.bounds;
}

- (void)setupTableView
{
  _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.contentView addSubview:_tableView];
  _dataSource = [[WBProfileDataSource alloc] initWithTableView:_tableView];
}

- (void)setupNavBar
{
  [super setupNavBar];
  [self setNavBarTitle:WBLS(@"profile_navbar_title")];
  [self setNavBarRightImage:[UIImage imageNamed:@"navbar_setting"]];
}

- (void)setupToolBar
{
  self.toolBar = [[WBRootToolBar alloc] init];
  [self.view addSubview:self.toolBar];
}

- (void)navBarRightAction:(id)sender
{
  WBSettingViewController *vc = [[WBSettingViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
