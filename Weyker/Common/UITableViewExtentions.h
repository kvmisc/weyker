//
//  UITableViewExtentions.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extentions)

- (__kindof UITableViewCell *)tk_dequeueReusableCellWithClass:(Class)cls;

- (__kindof UITableViewCell *)tk_dequeueReusableCellWithClass:(Class)cls forIndexPath:(NSIndexPath *)indexPath;

@end
