//
//  WBWeiboToken.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBWeiboToken.h"

@implementation WBWeiboToken

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [encoder encodeObject:_access_token forKey:@"kAccessToken"];
  [encoder encodeObject:_expires_in forKey:@"kExpiresIn"];
  [encoder encodeObject:_create_at forKey:@"kCreateAt"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
  self = [super init];
  if (self) {
    _access_token = [decoder decodeObjectForKey:@"kAccessToken"];
    _expires_in = [decoder decodeObjectForKey:@"kExpiresIn"];
    _create_at = [decoder decodeObjectForKey:@"kCreateAt"];
  }
  return self;
}

- (BOOL)notExpired
{
  if ( (_expires_in.length>0) && (_create_at.length>0) ) {
    NSDate *createAt = [NSDate dateWithTimeIntervalSince1970:[_create_at doubleValue]];
    NSDate *expiresAt = [createAt dateByAddingTimeInterval:[_expires_in doubleValue]];
    return ([expiresAt laterDate:[NSDate date]]==expiresAt);
  }
  return NO;
}

@end
