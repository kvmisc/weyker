//
//  WBTableViewDataSource.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewExtentions.h"
#import "WBSeparatorCell.h"

@interface WBTableViewDataSource : NSObject <
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, weak, readonly) UITableView *tableView;


- (id)initWithTableView:(UITableView *)tableView;

- (void)setup;

- (void)registerNib:(Class)cls;
- (void)registerNib:(Class)cls identifier:(NSString *)identifier;
- (void)registerClass:(Class)cls;
- (void)registerClass:(Class)cls identifier:(NSString *)identifier;

@end
