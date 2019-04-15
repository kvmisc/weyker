//
//  WBWeakScriptMessageHandler.m
//  GenericProj
//
//  Created by Haiping Wu on 2018/4/11.
//  Copyright © 2018 firefly.com. All rights reserved.
//

#import "WBWeakScriptMessageHandler.h"

@implementation WBWeakScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
  [_delegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
