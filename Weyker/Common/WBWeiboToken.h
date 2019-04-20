//
//  WBWeiboToken.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/20.
//  Copyright © 2019 migu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBWeiboToken : NSObject <
    NSCoding
>
//{
//  "access_token":"2.007PbFFD0OG9MW079addf400vUoffE",
//  "remind_in":"139296",
//  "expires_in":139296,
//  "uid":"2823615000",
//  "isRealName":"true"
//}
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *create_at;

- (BOOL)notExpired;

@end
