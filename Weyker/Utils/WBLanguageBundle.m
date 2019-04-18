//
//  WBLanguageBundle.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/18.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBLanguageBundle.h"
#import "WBLanguageManager.h"

@implementation WBLanguageBundle

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    //动态继承、交换，方法类似KVO，通过修改[NSBundle mainBundle]对象的isa指针，使其指向它的子类UWBundle，这样便可以调用子类的方法；其实这里也可以使用method_swizzling来交换mainBundle的实现，来动态判断，可以同样实现。
    object_setClass([NSBundle mainBundle], [self class]);
  });
}

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
  NSBundle *bundle = [[self class] tk_mainBundle];
  if ( bundle ) {
    return [bundle localizedStringForKey:key value:value table:tableName];
  } else {
    return [super localizedStringForKey:key value:value table:tableName];
  }
}

+ (NSBundle *)tk_mainBundle
{
  NSString *language = [WBLanguageManager currentLanguage];
  if ( language.length>0 ) {
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    if ( path.length>0 ) {
      return [NSBundle bundleWithPath:path];
    }
  }
  return nil;
}

@end
