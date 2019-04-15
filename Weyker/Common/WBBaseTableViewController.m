//
//  WBBaseTableViewController.m
//  GenericProj
//
//  Created by Kevin Wu on 9/8/17.
//  Copyright © 2017 firefly.com. All rights reserved.
//

#import "WBBaseTableViewController.h"

@implementation WBBaseTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ return 0; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ return nil; }

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ( [cell respondsToSelector:@selector(configLine:count:)] ) {
    NSInteger rowCount = [tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section];
    [(WBBaseTableViewCell *)cell configLine:indexPath.row count:rowCount];
  }
}

@end
