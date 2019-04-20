//
//  WBWeiboTokenRequest.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBWeiboTokenRequest : WBWeiboPostRequest

@property (nonatomic, copy) NSString *accessToken;

- (id)initWithCode:(NSString *)code;

@end
