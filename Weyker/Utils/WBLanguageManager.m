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
  NSString *code = [self fixedLanguage:[self currentLanguage]];
  [self updateLanguageBundle:code];
}

+ (NSArray *)availableLanguages
{
  return @[
           @{@"name":@"English", @"code":@"en"},
           @{@"name":@"简体中文", @"code":@"zh-Hans"},
           @{@"name":@"繁体中文", @"code":@"zh-Hant"}
           ];
}

+ (NSString *)currentLanguage
{
  NSArray *languageAry = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
  //WBLog(@"Languages: %@", [languageAry componentsJoinedByString:@", "]);
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

+ (void)changeToSystemLanguage
{
  [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AppleLanguages"];
  [[NSUserDefaults standardUserDefaults] synchronize];

  [self updateLanguageBundle:[self fixedLanguage:nil]];

  [[NSNotificationCenter defaultCenter] postNotificationName:WBLanguageDidChangeNotification object:nil];
}

+ (NSString *)fixedLanguage:(NSString *)code
{
  if ( [code hasPrefix:@"en"] ) {
    return WB_LANGUAGE_CODE_EN;
  } else if ( [code hasPrefix:@"zh-Hans"] ) {
    return WB_LANGUAGE_CODE_ZH_HANS;
  } else if ( [code hasPrefix:@"zh-Hant"] ) {
    return WB_LANGUAGE_CODE_ZH_HANT;
  } else {
    //return WB_LANGUAGE_CODE_ZH_HANS;
  }
  return WB_LANGUAGE_CODE_ZH_HANS;
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
