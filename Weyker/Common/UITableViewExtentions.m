//
//  UITableViewExtentions.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import "UITableViewExtentions.h"

@implementation UITableView (Extentions)

- (__kindof UITableViewCell *)tk_dequeueReusableCellWithClass:(Class)cls
{
  if ( cls ) {
    NSString *identifier = NSStringFromClass(cls);
    return [self dequeueReusableCellWithIdentifier:identifier];
  }
  return nil;
}

- (__kindof UITableViewCell *)tk_dequeueReusableCellWithClass:(Class)cls forIndexPath:(NSIndexPath *)indexPath
{
  if ( cls ) {
    NSString *identifier = NSStringFromClass(cls);
    return [self dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  }
  return nil;
}

@end
