//
//  WBLogger.h
//  GenericProj
//
//  Created by Kevin Wu on 8/8/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*******************************************************************************

 Code:

 WBLogError(@"player", @"Error: %d", 404);


 Output:

 [player] Error: 404


 Log Path:

 Library/Caches/Logs/com.firefly.genericproj 2016-08-08 06-13.log

 ******************************************************************************/

/* [CONFIGURABLE_VALUE] */
#define WB_USE_SYSTEM_LOG 1


#if WB_USE_SYSTEM_LOG

#define WBLog(_fmt_, ...)                NSLog(_fmt_, ##__VA_ARGS__)

#define WBLogError(_dmn_,_fmt_, ...)     NSLog(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogWarn(_dmn_,_fmt_, ...)      NSLog(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogInfo(_dmn_,_fmt_, ...)      NSLog(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogDebug(_dmn_,_fmt_, ...)     NSLog(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogVerbose(_dmn_,_fmt_, ...)   NSLog(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)

#else

#define WBLog(_fmt_, ...)                DDLogError(_fmt_, ##__VA_ARGS__)

#define WBLogError(_dmn_,_fmt_, ...)     DDLogError(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogWarn(_dmn_,_fmt_, ...)      DDLogWarn(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogInfo(_dmn_,_fmt_, ...)      DDLogInfo(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogDebug(_dmn_,_fmt_, ...)     DDLogDebug(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)
#define WBLogVerbose(_dmn_,_fmt_, ...)   DDLogVerbose(@"[%@] "_fmt_, _dmn_, ##__VA_ARGS__)

#endif


@interface WBLogger : NSObject

+ (void)setup;

@end
