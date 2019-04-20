//
//  WBWeiboTokenRequest.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils/WBWeiboPostRequest.h"
#import "WBWeiboToken.h"

@interface WBWeiboTokenRequest : WBWeiboPostRequest

@property (nonatomic, strong) WBWeiboToken *token;

- (id)initWithCode:(NSString *)code;

@end
