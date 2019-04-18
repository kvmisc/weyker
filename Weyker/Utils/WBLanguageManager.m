//
//  WBLanguageManager.m
//  GenericProj
//
//  Created by Haiping Wu on 2019/4/18.
//  Copyright © 2019 firefly.com. All rights reserved.
//

#import "WBLanguageManager.h"

@implementation WBLanguageManager

+ (NSString *)currentLanguage
{
  NSArray *languageAry = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
  return [languageAry firstObject];
}

+ (void)setLanguage:(NSString *)language
{
  if ( language.length>0 ) {
    [[NSUserDefaults standardUserDefaults] setObject:@[language] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:WBLanguageDidChangeNotification object:nil];
  }
}

@end
