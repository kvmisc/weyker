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
@property (nonatomic, strong) WBWeiboUidRequest *uidRequest;
@end

@implementation WBHomeViewController {
  UIButton *_bt;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.contentView.backgroundColor = [UIColor lightGrayColor];



}

- (void)setupNavBar
{
  [super setupNavBar];

  self.navBar.titleLabel.text = @"时间线";
  self.navigationItem.title = @"时间线";

  [self.navBar.rightBtn setTitle:@"下一个" forState:UIControlStateNormal];
}

- (void)setupToolBar
{
  self.toolBar = [[WBRootToolBar alloc] init];
  [self.view addSubview:self.toolBar];
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
//  NSLog(@"before: %@", [WBLanguageManager currentLanguage]);
//  NSLog(@"to: default");
//  [WBLanguageManager changeToSystemLanguage];
//  NSLog(@"become: %@", [WBLanguageManager currentLanguage]);


//  NSMutableString *str = [[NSMutableString alloc] initWithString:@"https://api.weibo.com/2/account/get_uid.json"];
////  NSMutableString *str = [[NSMutableString alloc] initWithString:@"https://api.weibo.com/oauth2/get_token_info"];
//
//  NSString *key = @"access_token";
//  NSString *token = @"2.00lpwkiH0OG9MW6181fb0a71trcOXE";
//  [str appendFormat:@"?%@=%@", [key tk_URLEncodedString], [token tk_URLEncodedString]];
//  NSLog(@"%@", str);


//  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//  AFHTTPSessionManager *HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];

  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
  AFHTTPSessionManager *HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:WB_API_BASE_URL]];

  AFHTTPResponseSerializer *serializer = [[AFHTTPResponseSerializer alloc] init];
  HTTPSessionManager.responseSerializer = serializer;



  NSString *key = @"access_token";
//  NSString *token = @"2.007PbFFD0OG9MW079addf400vUoffE";
  NSString *token = @"2.00lpwkiH0OG9MW6181fb0a71trcOXE";
  _uidRequest = [[WBWeiboUidRequest alloc] initWithToken:token];
//  _uidRequest.HTTPManager = HTTPSessionManager;
//  _uidRequest.address = @"2/account/get_uid.json";
//  [_uidRequest.queries tk_setParameterStr:token forKey:key];
//  _uidRequest.method = @"GET";
  [_uidRequest start:^(WBHTTPRequest *request, NSError *error) {
    NSLog(@"%@", self.uidRequest.uid);
  }];

//  Class cls = NSClassFromString(@"WBPushChildViewController");
//  UIViewController *vc = [[cls alloc] init];
//  [self.navigationController pushViewController:vc animated:YES];
}

@end
