//
//  WBAccountManager.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBAccountManager.h"

@implementation WBAccountManager

+ (WBAccountManager *)sharedObject
{
  static WBAccountManager *AccountManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    AccountManager = [[self alloc] init];
  });
  return AccountManager;
}

- (BOOL)isAccountValid
{
  return ((_uid.length>0) && (_token) && ([_token notExpired]));
}

- (BOOL)loadLastAccount
{
  NSString *uid = [[self signinedAccounts] firstObject];
  if ( uid.length>0 ) {
    NSString *path = [WBGlobal pathUser:uid relativePath:@"token"];
    WBWeiboToken *token = TKLoadArchivableObject(path);
    if ( (token) && [token notExpired] ) {
      _uid = [uid copy];
      _token = token;
      return YES;
    }
    return NO;
  }
  return NO;
}

- (BOOL)loadEverAccount:(NSString *)uid
{
  if ( (uid.length>0) && ([[self signinedAccounts] containsObject:uid]) ) {
    NSString *path = [WBGlobal pathUser:uid relativePath:@"token"];
    WBWeiboToken *token = TKLoadArchivableObject(path);
    if ( token ) {
      _uid = [uid copy];
      _token = token;
      return YES;
    }
    return NO;
  }
  return NO;
}

- (void)saveAccount:(NSString *)uid token:(WBWeiboToken *)token
{
  if ( (uid.length>0) && (token) && ([token notExpired]) ) {
    TKCreateDirectory([WBGlobal pathUser:uid relativePath:nil]);
    NSString *path = [WBGlobal pathUser:uid relativePath:@"token"];
    TKSaveArchivableObject(token, path);

    NSMutableArray *accountAry = [[NSMutableArray alloc] init];
    [accountAry addObject:uid];
    NSArray *oldAccountAry = [self signinedAccounts];
    for ( NSUInteger i=0; i<oldAccountAry.count; ++i ) {
      NSString *it = [oldAccountAry objectAtIndex:i];
      [accountAry tk_addUnequalObjectIfNotNil:it];
    }
    [[NSUserDefaults standardUserDefaults] setObject:accountAry forKey:@"SigninedAccounts"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

- (NSArray *)signinedAccounts
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"SigninedAccounts"];
}

@end
