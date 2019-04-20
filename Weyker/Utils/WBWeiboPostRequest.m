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
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:WB_API_BASE_URL]
                                                           sessionConfiguration:configuration];
  AFHTTPResponseSerializer *serializer = [[AFHTTPResponseSerializer alloc] init];
  manager.responseSerializer = serializer;

  self.HTTPManager = manager;

  [self.parameters tk_setParameterStr:WB_WEIBO_APP_KEY forKey:@"client_id"];
  [self.parameters tk_setParameterStr:WB_WEIBO_APP_SECRET forKey:@"client_secret"];
}

@end
