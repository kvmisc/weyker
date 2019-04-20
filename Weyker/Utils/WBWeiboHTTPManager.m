//
//  WBWeiboHTTPManager.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBWeiboHTTPManager.h"

@implementation WBWeiboHTTPManager

+ (AFHTTPSessionManager *)HTTPSessionManager
{
  static AFHTTPSessionManager *HTTPSessionManager = nil;
  if ( !HTTPSessionManager ) {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:WB_API_BASE_URL]
                                                  sessionConfiguration:configuration];
    AFHTTPResponseSerializer *serializer = [[AFHTTPResponseSerializer alloc] init];
    HTTPSessionManager.responseSerializer = serializer;
  }
  return HTTPSessionManager;
}

@end
