//
//  WBLanguageManager.m
//  GenericProj
//
//  Created by Haiping Wu on 2019/4/18.
//  Copyright © 2019 firefly.com. All rights reserved.
//

#import "WBLanguageManager.h"

NSBundle *WBLanguageBundle = nil;

@implementation WBLanguageManager

+ (void)setup
{
  NSString *code = nil;
  NSString *currentLanguage = [self currentLanguage];
  if ( [currentLanguage hasPrefix:@"en"] ) {
    code = WB_LANGUAGE_CODE_EN;
  } else if ( [currentLanguage hasPrefix:@"zh-Hans"] ) {
    code = WB_LANGUAGE_CODE_ZH_HANS;
  } else if ( [currentLanguage hasPrefix:@"zh-Hant"] ) {
    code = WB_LANGUAGE_CODE_ZH_HANT;
  } else {
    code = WB_LANGUAGE_CODE_EN;
  }

  [self updateLanguageBundle:code];
}

+ (NSArray *)availableLanguages
{
  return @[
           @{@"name":@"English", @"code":@"en"},
           @{@"name":@"简体中文", @"code":@"zh-Hans"},
           ];
}

+ (NSString *)currentLanguage
{
  NSArray *languageAry = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
  return [languageAry firstObject];
}
+ (void)changeToLanguage:(NSString *)code
{
  if ( code.length>0 ) {
    [[NSUserDefaults standardUserDefaults] setObject:@[code] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self updateLanguageBundle:code];

    [[NSNotificationCenter defaultCenter] postNotificationName:WBLanguageDidChangeNotification object:nil];
  }
}

+ (void)updateLanguageBundle:(NSString *)code
{
  if ( code.length>0 ) {
    NSString *path = [[NSBundle mainBundle] pathForResource:code ofType:@"lproj"];
    if ( path.length>0 ) {
      WBLanguageBundle = [NSBundle bundleWithPath:path];
    }
  }
}

@end
