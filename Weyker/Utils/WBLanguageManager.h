//
//  WBLanguageManager.h
//  GenericProj
//
//  Created by Haiping Wu on 2019/4/18.
//  Copyright © 2019 firefly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WB_LANGUAGE_CODE_EN @"en"
#define WB_LANGUAGE_CODE_ZH_HANS @"zh-Hans"
#define WB_LANGUAGE_CODE_ZH_HANT @"zh-Hant"

#define WBLanguageDidChangeNotification @"WBLanguageDidChangeNotification"

@interface WBLanguageManager : NSObject

+ (NSString *)currentLanguage;

+ (void)setLanguage:(NSString *)language;

@end
