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
@property (nonatomic, strong) WBHTTPRequest *request;
@end

@implementation WBProfileViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setupTableView];



  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.weibo.com/"]
                                                           sessionConfiguration:configuration];
  AFHTTPResponseSerializer *serializer = [[AFHTTPResponseSerializer alloc] init];
  manager.responseSerializer = serializer;

  self.request = [[WBHTTPRequest alloc] init];
  self.request.HTTPManager = manager;
  //self.request.address = @"users/show.json";
  self.request.address = @"2/statuses/home_timeline.json";
  self.request.method = @"GET";

//  [self.request.queries tk_setParameterStr:@"9ea6c0cfc687f731c6ca0b2623530763" forKey:@"access_token"];
////  [self.request start:^(WBHTTPRequest *request, NSError *error) {
////    NSString *str = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
////    NSLog(@"req: %@", str);
////  }];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  _tableView.frame = self.contentView.bounds;
}

- (void)setupTableView
{
  _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.contentView addSubview:_tableView];
  _dataSource = [[WBProfileDataSource alloc] initWithTableView:_tableView];
}

- (void)setupNavBar
{
  [super setupNavBar];
  [self setNavBarLeftTitle:@"登录"];
  [self setNavBarTitle:WBLS(@"profile_navbar_title")];
  [self setNavBarRightImage:[UIImage imageNamed:@"navbar_setting"]];
}

- (void)setupToolBar
{
  self.toolBar = [[WBRootToolBar alloc] init];
  [self.view addSubview:self.toolBar];
}

- (void)navBarLeftAction:(id)sender
{
  if ( [[WBAccountManager sharedObject] isAccountValid] ) {
    NSLog(@"%@", [[WBAccountManager sharedObject] signinedAccounts]);
  } else {
    @weakify(self);
    WBAuthorizeView *authorizeView = [[WBAuthorizeView alloc] init];
    [authorizeView prepareForView:WB_APP_DELEGATE.window viewport:nil];
    [authorizeView.coverView show:YES];
    [authorizeView startAuthorize:^(NSString *uid, WBWeiboToken *token) {
      @strongify(self);
      WBLog(@"%@ %@", uid, token.access_token);
      if ( (uid.length>0) && (token) && ([token notExpired]) ) {
        [[WBAccountManager sharedObject] saveAccount:uid token:token];
        [WBMC INF:WB_APP_DELEGATE.window info:@"YES"];
      } else {
        [WBMC INF:WB_APP_DELEGATE.window info:@"NO"];
      }
    }];
  }
}
- (void)navBarRightAction:(id)sender
{
  WBSettingViewController *vc = [[WBSettingViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
