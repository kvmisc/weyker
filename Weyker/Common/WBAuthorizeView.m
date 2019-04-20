//
//  WBAuthorizeView.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/15.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBAuthorizeView.h"
#import "WBWeakScriptMessageHandler.h"

@interface WBAuthorizeView () <
    WKNavigationDelegate,
    WKUIDelegate,
    WKScriptMessageHandler
>

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) WBWeiboTokenRequest *tokenRequest;
@property (nonatomic, strong) WBWeiboUidRequest *uidRequest;

@property (nonatomic, copy) void (^completion)(NSString *uid, WBWeiboToken *token);

@end


@implementation WBAuthorizeView {
  NSMutableDictionary *_messageMap;
  WBWeakScriptMessageHandler *_messageHandler;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self setup];
  }
  return self;
}



- (void)setup
{
  _request = nil;
  _messageMap = [[NSMutableDictionary alloc] init];
  _messageHandler = [[WBWeakScriptMessageHandler alloc] init];
  _messageHandler.delegate = self;

  WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
  _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
  _webView.UIDelegate = self;
  _webView.navigationDelegate = self;
  [self addSubview:_webView];
  //[self clearWebViewCache];
  //[self scalePageToFit];

  @weakify(self);

  _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
  [self addSubview:_progressView];
  [self.KVOController observe:_webView keyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary<NSString *,id> *change) {
    @strongify(self);
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = (self.webView.estimatedProgress>=0.98);
  }];

  _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [_closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
  [_closeBtn addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_closeBtn];

  self.backgroundColor = TKRGBA(0, 0, 0, 0.5);
  self.layer.cornerRadius = 10.0;
}

- (void)closeButtonClicked:(id)sender
{
  if ( _completion ) {
    _completion(nil, nil);
  }
  [_tokenRequest cancel];
  [_uidRequest cancel];
  [self.coverView hide:YES];
}

#ifdef DEBUG
- (void)dealloc { WBPrintMethod(); }
#endif

- (void)layoutSubviews
{
  [super layoutSubviews];
  _webView.frame = CGRectMake(10.0, 10.0, self.bounds.size.width-20.0, self.bounds.size.height-20.0);
  _progressView.frame = CGRectMake(10.0, 10.0, self.bounds.size.width-20.0, _progressView.bounds.size.height);
  _closeBtn.frame = CGRectMake(self.bounds.size.width-30.0, -10.0, 40.0, 40.0);
}

- (void)startAuthorize:(void (^)(NSString *uid, WBWeiboToken *token))completion
{
  if ( completion ) {
    _completion = [completion copy];
  }

  NSMutableString *url = [[NSMutableString alloc] initWithString:WB_API_BASE_URL];
  [url appendString:@"oauth2/authorize"];
  NSDictionary *queries = @{
                            @"client_id": WB_WEIBO_APP_KEY,
                            @"redirect_uri": WB_AUTHORIZE_REDIRECT_URI,
                            @"scope": WB_AUTHORIZE_SCOPE_ALL,
                            @"display": @"mobile"
                            };
  [url tk_addQueryDictionary:queries];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
  [self loadRequest:request];
}

- (void)requestAccessToken:(NSString *)code
{
  if ( !_tokenRequest ) {
    _tokenRequest = [[WBWeiboTokenRequest alloc] initWithCode:code];
  }
  [_tokenRequest cancel];

  @weakify(self);
  [_tokenRequest start:^(WBHTTPRequest *request, NSError *error) {
    @strongify(self);
    if ( self.tokenRequest.token ) {
      [self requestUid:self.tokenRequest.token];
    } else {
      if ( self.completion ) {
        self.completion(nil, nil);
      }
    }
  }];
}

- (void)requestUid:(WBWeiboToken *)token
{
  if ( !_uidRequest ) {
    _uidRequest = [[WBWeiboUidRequest alloc] initWithToken:token.access_token];
  }
  [_uidRequest cancel];

  @weakify(self);
  [_uidRequest start:^(WBHTTPRequest *request, NSError *error) {
    @strongify(self);
    if ( self.uidRequest.uid.length>0 ) {
      if ( self.completion ) {
        self.completion(self.uidRequest.uid, token);
      }
    } else {
      if ( self.completion ) {
        self.completion(nil, nil);
      }
    }
    [self.coverView hide:YES];
  }];
}

- (void)loadRequest:(NSURLRequest *)request
{
  _request = request;
  [_webView loadRequest:_request];
}

- (void)clearWebViewCache
{
  NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                  WKWebsiteDataTypeDiskCache,
                                                  //WKWebsiteDataTypeOfflineWebApplicationCache,
                                                  WKWebsiteDataTypeMemoryCache,
                                                  //WKWebsiteDataTypeLocalStorage,
                                                  //WKWebsiteDataTypeCookies,
                                                  //WKWebsiteDataTypeSessionStorage,
                                                  //WKWebsiteDataTypeIndexedDBDatabases,
                                                  //WKWebsiteDataTypeWebSQLDatabases
                                                  ]];
  //// All kinds of data
  //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
  //// Date from
  NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
  //// Execute
  [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    // Done
  }];
}

- (void)scalePageToFit
{
  NSString *scaleJS = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
  [self injectJavaScript:scaleJS];
}

- (void)injectJavaScript:(NSString *)js
{
  if ( js.length>0 && (_webView) ) {
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [_webView.configuration.userContentController addUserScript:script];
  }
}


- (void)subscribeMessage:(NSString *)name handler:(void (^)(WKUserContentController *ucc, WKScriptMessage *sm))handler;
{
  if ( name.length>0 ) {
    if ( handler ) {
      [_messageMap setObject:[handler copy] forKey:name];
    } else {
      [_messageMap removeObjectForKey:name];
    }
    [_webView.configuration.userContentController addScriptMessageHandler:_messageHandler name:name];
  }
}

- (void)unsubscribeMessage:(NSString *)name
{
  if ( name.length>0 ) {
    [_messageMap removeObjectForKey:name];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:name];
  }
}

- (void)unsubscribeAllMessages
{
  @weakify(self);
  [_messageMap enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
    @strongify(self);
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:key];
  }];
  [_messageMap removeAllObjects];
}




- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
  WBPrintMethod();
  void (^handler)(WKUserContentController *ucc, WKScriptMessage *sm) = [_messageMap objectForKey:message.name];
  if ( handler ) {
    handler(userContentController, message);
  }
}




#pragma mark - CoverView

- (void)prepareForView:(UIView *)inView viewport:(UIView *)viewport
{
  [super prepareForView:inView viewport:viewport];

  self.coverView.touchBackgroundToHide = NO;

  self.frame = CGRectMake(20.0,
                          20.0,
                          self.coverView.bounds.size.width-2*20.0,
                          self.coverView.bounds.size.height-2*20.0);
  self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0);
}
- (void)updateStateFromAnimation:(BOOL)completion
{
  if ( completion ) {
    if ( [self.coverView isShowing] ) {
      self.layer.transform = CATransform3DIdentity;
    } else if ( [self.coverView isHiding] ) {
      self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
  } else {
    if ( [self.coverView isShowing] || [self.coverView isHiding] ) {
      if ( self.layer.presentationLayer ) {
        self.layer.transform = self.layer.presentationLayer.transform;
      }
    }
  }
}
- (CAAnimation *)showAnimation
{
  CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform"];
  // 模拟质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大。默认值 1
  animation.mass = 1.0;
  // 刚度系数（劲度系数/弹性系数），刚度系数越大，形变产生的力就越大，运动越快。默认值 100
  animation.stiffness = 100.0;
  // 阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快。默认值 10
  animation.damping = 500.0;
  // 初始速率，动画视图的初始速度大小。默认值 0
  // 速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
  animation.initialVelocity = 15.0;
  // 估算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算
  WBLogDebug(@"CoverView", @"spring duration: %f", animation.settlingDuration);
  animation.duration = animation.settlingDuration;
  animation.fromValue = [NSValue valueWithCATransform3D:self.layer.transform];
  animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
  return animation;
}
- (CAAnimation *)hideAnimation
{
  CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform"];
  animation.fromValue = [NSValue valueWithCATransform3D:self.layer.transform];
  animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
  return animation;
}


#pragma mark - WKNavigationDelegate

// Decides whether to allow or cancel a navigation.
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
  WBPrintMethod();
  NSString *url = navigationAction.request.URL.absoluteString;
  WBLog(@"Load: %@", url);
  if ( [url hasPrefix:WB_AUTHORIZE_REDIRECT_URI] ) {
    NSString *code = [[url tk_queryDictionary] objectForKey:@"code"];
    if ( code.length>0 ) {
      [self requestAccessToken:code];
    } else {
      // 虽然这次没拿到 token，万一新浪还会打开这网址呢，等着。用户可以手动关闭这个窗口的。
    }
  }
  decisionHandler(WKNavigationActionPolicyAllow);
}
// Decides whether to allow or cancel a navigation after its response is known.
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
  WBPrintMethod();
  decisionHandler(WKNavigationResponsePolicyAllow);
}

// Called when web content begins to load in a web view.
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
  WBPrintMethod();
}
// Called when a web view receives a server redirect.
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
  WBPrintMethod();
}
// Called when an error occurs while the web view is loading content.
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
  WBPrintMethod();
}

// Called when the web view begins to receive web content.
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
  WBPrintMethod();
}
// Called when the navigation is complete.
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
  WBPrintMethod();
}
// Called when an error occurs during navigation.
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
  WBPrintMethod();
}

// Called when the web view needs to respond to an authentication challenge.
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
  WBPrintMethod();
  completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

// Called when the web view’s web content process is terminated.
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
  WBPrintMethod();
}


#pragma mark - WKUIDelegate

// Creates a new web view.
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
  WBPrintMethod();
  return nil;
}

// Notifies your app that the DOM window closed successfully.
- (void)webViewDidClose:(WKWebView *)webView
{
  WBPrintMethod();
}

// Determines whether the given element should show a preview.
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo
{
  WBPrintMethod();
  return NO;
}
// Called when the user performs a peek action.
- (UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions
{
  WBPrintMethod();
  return nil;
}
// Called when the user performs a pop action on the preview.
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController
{
  WBPrintMethod();
}

// Displays a JavaScript alert panel.
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
  WBPrintMethod();
  [UIAlertController tk_presentAlert:@"" message:message confirm:@"OK" completion:^{
    if ( completionHandler ) { completionHandler(); }
  }];
}
// Displays a JavaScript confirm panel.
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
  WBPrintMethod();
  [UIAlertController tk_presentConfirm:@"" message:message cancel:@"Cancel" confirm:@"OK" completion:^(BOOL result) {
    if ( completionHandler ) { completionHandler(result); }
  }];
}
// Displays a JavaScript text input panel.
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
  WBPrintMethod();
  [UIAlertController tk_presentInput:@"" message:prompt field:^(UITextField *textField) {
    textField.text = defaultText;
  } cancel:@"Cancel" confirm:@"OK" completion:^(BOOL result, NSString *string) {
    if ( completionHandler ) {
      if ( result ) {
        completionHandler(string);
      } else {
        completionHandler(nil);
      }
    }
  }];
}


@end
