//
//  WBHTTPError.h
//  GenericProj
//
//  Created by Kevin Wu on 9/12/17.
//  Copyright © 2017 firefly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/* [CONFIGURABLE_VALUE] */
#define WB_HTTP_SUCCESS_CODE @"200"


#define WB_ERROR_DOMAIN_HTTP @"com.firefly.ios.http"

#define WB_ERROR_CODE_HTTP_UNKNOWN 1000
#define WB_ERROR_CODE_HTTP_EMPTY_RESPONSE 1001
#define WB_ERROR_CODE_HTTP_INVALID_RESPONSE 1002
#define WB_ERROR_CODE_HTTP_OPERATION_FAILED 1003


@interface WBHTTPError : NSObject

+ (NSError *)unknownError;

+ (NSError *)emptyResponseError;

+ (NSError *)invalidResponseError;

+ (NSError *)operationFailedError;

+ (NSError *)errorWithCode:(NSInteger)code reason:(NSString *)reason;

@end
