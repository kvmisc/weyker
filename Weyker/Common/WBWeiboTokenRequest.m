//
//  WBWeiboTokenRequest.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBWeiboTokenRequest.h"

@implementation WBWeiboTokenRequest

- (id)initWithCode:(NSString *)code
{
  self = [super init];
  if (self) {
    if ( code.length>0 ) {
      [self.parameters tk_setParameterStr:code forKey:@"code"];
    } else {
      return nil;
    }
  }
  return self;
}

- (void)setup
{
  [super setup];

  self.address = @"oauth2/access_token";
  self.method = @"POST";

  [self.parameters tk_setParameterStr:@"authorization_code" forKey:@"grant_type"];
  [self.parameters tk_setParameterStr:WB_AUTHORIZE_REDIRECT_URI forKey:@"redirect_uri"];
}

- (void)parse:(id)object
{
  WBWeiboToken *token = [WBWeiboToken yy_modelWithDictionary:object];
  if ( (token.access_token.length>0)
      && (token.expires_in.length>0)
      && (token.expires_in.integerValue>0) )
  {
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *createAt = [[NSString alloc] initWithFormat:@"%lf", timestamp];
    token.create_at = createAt;

    _token = token;
  }
}

@end
