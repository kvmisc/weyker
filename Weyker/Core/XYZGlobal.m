//
//  XYZGlobal.m
//  GenericProj
//
//  Created by Kevin Wu on 8/15/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

#import "XYZGlobal.h"

@implementation XYZGlobal

+ (UIWindow *)visibleTopmostWindow
{
  NSArray *windowAry = [[UIApplication sharedApplication] windows];
  for ( UIWindow *wnd in [windowAry reverseObjectEnumerator] ) {
    if ( !(wnd.hidden) ) {
      return wnd;
    }
  }
  return nil;
}

+ (UIViewController *)topmostViewController
{
  UIWindow *window = [XYZ_APP_DELEGATE window];
  UIViewController *front = window.rootViewController;
  while ( front.presentedViewController ) {
    front = front.presentedViewController;
  }
  return front;
}



+ (BOOL)isVersionValid:(NSString *)ver
{
  if ( ver.length<=0 ) {
    // 长度为0，版本号无效
    return NO;
  }

  NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
  for ( NSUInteger i=0; i<[ver length]; ++i ) {
    if ( ![set characterIsMember:[ver characterAtIndex:i]] ) {
      // 含有非法字符，版本号无效
      return NO;
    }
  }

  NSArray *ary = [ver componentsSeparatedByString:@"."];
  for ( NSString *com in ary ) {
    if ( com.length<=0 ) {
      // 某一段为空，版本号无效
      return NO;
    }
    if ( [com hasPrefix:@"0"] && ([com integerValue]>0) ) {
      // 某一段以0开头，值却不是0，版本号无效
      return NO;
    }
  }

  return YES;
}
+ (BOOL)isVersion:(NSString *)ver1 equalTo:(NSString *)ver2
{
  NSAssert2(([self isVersionValid:ver1]&&[self isVersionValid:ver2]), @"ver1:%@, ver2:%@", ver1, ver2);
  NSComparisonResult result = [self compareVersion:ver1 version:ver2];
  return (result==NSOrderedSame);
}
+ (BOOL)isVersion:(NSString *)ver1 lessThan:(NSString *)ver2
{
  NSAssert2(([self isVersionValid:ver1]&&[self isVersionValid:ver2]), @"ver1:%@, ver2:%@", ver1, ver2);
  NSComparisonResult result = [self compareVersion:ver1 version:ver2];
  return (result==NSOrderedAscending);
}
+ (BOOL)isVersion:(NSString *)ver1 lessOrEqual:(NSString *)ver2
{
  NSAssert2(([self isVersionValid:ver1]&&[self isVersionValid:ver2]), @"ver1:%@, ver2:%@", ver1, ver2);
  NSComparisonResult result = [self compareVersion:ver1 version:ver2];
  return ((result==NSOrderedSame) || (result==NSOrderedAscending));
}
+ (BOOL)isVersion:(NSString *)ver1 greaterThan:(NSString *)ver2
{
  NSAssert2(([self isVersionValid:ver1]&&[self isVersionValid:ver2]), @"ver1:%@, ver2:%@", ver1, ver2);
  NSComparisonResult result = [self compareVersion:ver1 version:ver2];
  return (result==NSOrderedDescending);
}
+ (BOOL)isVersion:(NSString *)ver1 greaterOrEqual:(NSString *)ver2
{
  NSAssert2(([self isVersionValid:ver1]&&[self isVersionValid:ver2]), @"ver1:%@, ver2:%@", ver1, ver2);
  NSComparisonResult result = [self compareVersion:ver1 version:ver2];
  return ((result==NSOrderedSame) || (result==NSOrderedDescending));
}
+ (NSComparisonResult)compareVersion:(NSString *)ver1 version:(NSString *)ver2
{
  NSArray *ary1 = [ver1 componentsSeparatedByString:@"."];
  NSArray *ary2 = [ver2 componentsSeparatedByString:@"."];
  NSUInteger maxCount = MAX([ary1 count], [ary2 count]);

  for ( NSUInteger i=0; i<maxCount; ++i ) {
    NSString *com1 = [ary1 tk_objectOrNilAtIndex:i];
    NSString *com2 = [ary2 tk_objectOrNilAtIndex:i];

    if ( com1.length>0 ) {
      if ( com2.length>0 ) {
        // 同时不为空
        if ( [com1 integerValue]<[com2 integerValue] ) {
          return NSOrderedAscending; // 已经有结果，升
        } else if ( [com1 integerValue]>[com2 integerValue] ) {
          return NSOrderedDescending; // 已经有结果，降
        } else {
          continue; // 相同，比较下一组
        }
      } else {
        // 第一段不空，第二段空
        return NSOrderedDescending; // 不管第一段是啥，降
      }
    } else {
      if ( com2.length>0 ) {
        // 第一段空，第二段不空
        return NSOrderedAscending; // 不管第二段是啥，升
      } else {
        // 同时为空
        continue; // 相同，比较下一组
      }
    }
  }

  return NSOrderedSame;
}



+ (CGFloat)boundFlt:(CGFloat)value left:(CGFloat)left right:(CGFloat)right
{
  if ( value<=left ) { return left; }
  if ( value>=right ) { return right; }
  return value;
}
+ (NSInteger)boundInt:(NSInteger)value left:(NSInteger)left right:(NSInteger)right
{
  if ( value<=left ) { return left; }
  if ( value>=right ) { return right; }
  return value;
}



+ (NSString *)pathGlobal:(NSString *)relativePath
{
  return TKPathForDocumentResource(relativePath);
}
+ (NSString *)pathGlobal:(NSString *)service file:(NSString *)file
{
  NSString *path1 = TKPathForDocumentResource(service);
  return [path1 stringByAppendingPathComponent:file];
}
+ (NSString *)pathUser:(NSString *)uid relativePath:(NSString *)relativePath
{
  NSString *path1 = TKPathForDocumentResource(@"Users");
  NSString *path2 = [path1 stringByAppendingPathComponent:uid];
  return [path2 stringByAppendingPathComponent:relativePath];
}
+ (NSString *)pathUser:(NSString *)uid service:(NSString *)service file:(NSString *)file
{
  NSString *path1 = TKPathForDocumentResource(@"Users");
  NSString *path2 = [path1 stringByAppendingPathComponent:uid];
  NSString *path3 = [path2 stringByAppendingPathComponent:service];
  return [path3 stringByAppendingPathComponent:file];
}

@end
