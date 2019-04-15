//
//  WBDateFormatter.m
//  SmartCombat
//
//  Created by Kevin Wu on 11/12/2017.
//  Copyright © 2017 Kevin Wu. All rights reserved.
//

#import "WBDateFormatter.h"

// yyyy-MM-dd HH:mm:ss
NSDateFormatter *WBDateFormatter01 = nil;

// yyyy-MM-dd
NSDateFormatter *WBDateFormatter21 = nil;
// yyyy-MM
NSDateFormatter *WBDateFormatter22 = nil;

// HH:mm:ss
NSDateFormatter *WBDateFormatter41 = nil;


@implementation WBDateFormatter

+ (void)setup
{
  // yyyy-MM-dd HH:mm:ss
  WBDateFormatter01 = [[NSDateFormatter alloc] init];
  [WBDateFormatter01 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  [WBDateFormatter01 setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
  [WBDateFormatter01 setTimeZone:[NSTimeZone systemTimeZone]];

  // yyyy-MM-dd
  WBDateFormatter21 = [[NSDateFormatter alloc] init];
  [WBDateFormatter21 setDateFormat:@"yyyy-MM-dd"];
  [WBDateFormatter21 setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
  [WBDateFormatter21 setTimeZone:[NSTimeZone systemTimeZone]];
  // yyyy-MM
  WBDateFormatter22 = [[NSDateFormatter alloc] init];
  [WBDateFormatter22 setDateFormat:@"yyyy-MM"];
  [WBDateFormatter22 setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
  [WBDateFormatter22 setTimeZone:[NSTimeZone systemTimeZone]];

  // HH:mm:ss
  WBDateFormatter41 = [[NSDateFormatter alloc] init];
  [WBDateFormatter41 setDateFormat:@"HH:mm:ss"];
  [WBDateFormatter41 setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
  [WBDateFormatter41 setTimeZone:[NSTimeZone systemTimeZone]];
}

@end
