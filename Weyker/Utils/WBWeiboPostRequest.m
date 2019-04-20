//
//  WBWeiboPostRequest.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBWeiboPostRequest.h"

@implementation WBWeiboPostRequest

- (void)setup
{
  self.HTTPManager = [WBWeiboHTTPManager HTTPSessionManager];

  [self.parameters tk_setParameterStr:WB_WEIBO_APP_KEY forKey:@"client_id"];
  [self.parameters tk_setParameterStr:WB_WEIBO_APP_SECRET forKey:@"client_secret"];
}

@end
