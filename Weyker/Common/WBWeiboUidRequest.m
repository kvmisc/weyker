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

  self.address = @"2/account/get_uid.json";
  self.method = @"GET";
}

- (void)parse:(id)object
{
  NSLog(@"%@", object);
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
