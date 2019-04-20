//
//  WBWeiboGetRequest.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBWeiboGetRequest.h"

@implementation WBWeiboGetRequest

- (void)setup
{
  self.HTTPManager = [WBWeiboHTTPManager HTTPSessionManager];

  [self.queries tk_setParameterStr:WB_WEIBO_APP_KEY forKey:@"client_id"];
}

@end
