//
//  WBWeiboUidRequest.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBWeiboUidRequest.h"

@implementation WBWeiboUidRequest

- (id)initWithToken:(NSString *)token
{
  self = [super init];
  if (self) {
    if ( token.length>0 ) {
      [self.queries tk_setParameterStr:token forKey:@"access_token"];
    } else {
      return nil;
    }
  }
  return self;
}

- (void)setup
{
  [super setup];

//  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//  AFHTTPSessionManager *HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
////  HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:WB_API_BASE_URL]
////                                                sessionConfiguration:configuration];
//  AFHTTPResponseSerializer *serializer = [[AFJSONResponseSerializer alloc] init];
//  HTTPSessionManager.responseSerializer = serializer;
//  self.HTTPManager = HTTPSessionManager;


  //self.address = @"https://www.baidu.com/"; //@"2/account/get_uid.json";
  //self.method = @"GET";
}

- (void)parse:(id)object
{
//  NSString *str = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
//  NSLog(@"%@", str);
//  NSLog(@"%@", object);
  self.uid = [object objectForKey:@"uid"];
//  WBWeiboToken *token = [WBWeiboToken yy_modelWithDictionary:object];
//  if ( (token.access_token.length>0)
//      && (token.expires_in.length>0)
//      && (token.expires_in.integerValue>0) )
//  {
//    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
//    NSString *createAt = [[NSString alloc] initWithFormat:@"%lf", timestamp];
//    token.create_at = createAt;
//
//    _token = token;
//  }
}

@end
