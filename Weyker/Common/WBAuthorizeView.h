//
//  WBAuthorizeView.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/15.
//  Copyright © 2019 migu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WBAuthorizeView : WBCoverContentView

@property (nonatomic, strong, readonly) WKWebView *webView;
@property (nonatomic, strong, readonly) NSURLRequest *request;

- (void)startAuthorize:(void (^)(NSString *token))completion;

- (void)loadRequest:(NSURLRequest *)request;

- (void)clearWebViewCache;

- (void)scalePageToFit;

- (void)injectJavaScript:(NSString *)js;

- (void)subscribeMessage:(NSString *)name handler:(void (^)(WKUserContentController *ucc, WKScriptMessage *sm))handler;
- (void)unsubscribeMessage:(NSString *)name;
- (void)unsubscribeAllMessages;

@end
