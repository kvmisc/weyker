//
//  WBAccountManager.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common/WBAuthorizeView.h"

@interface WBAccountManager : NSObject

@property (nonatomic, copy, readonly) NSString *uid;
@property (nonatomic, strong, readonly) WBWeiboToken *token;

+ (WBAccountManager *)sharedObject;

// 已加载帐号，且帐号未过期
- (BOOL)isAccountValid;

// 加载上次登录成功的帐号，如果帐号过期，uid 和 token 置为空
// 找到帐号，且未过期，则返回 YES
- (BOOL)loadLastAccount;
// 加载任意已保存的帐号，不管是否过期
// 找到帐号，则返回 YES
- (BOOL)loadEverAccount:(NSString *)uid;

// 登录成功以后设置到 uid 和 token，并保存到磁盘
- (void)saveAccount:(NSString *)uid token:(WBWeiboToken *)token;

// 曾经登录过的帐号 ID，第一个为上次登录的帐号 ID
- (NSArray *)signinedAccounts;

@end
