//
//  WBWeiboAccessTokenRequest.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBWeiboAccessTokenRequest.h"

@implementation WBWeiboAccessTokenRequest

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
  NSString *str = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
  NSLog(@"%@", str);
  NSLog(@"%@", object);
}

@end
