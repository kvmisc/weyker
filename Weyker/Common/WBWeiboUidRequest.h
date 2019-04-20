//
//  WBWeiboUidRequest.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils/WBWeiboGetRequest.h"

@interface WBWeiboUidRequest : WBWeiboGetRequest

@property (nonatomic, copy) NSString *uid;

- (id)initWithToken:(NSString *)token;

@end
