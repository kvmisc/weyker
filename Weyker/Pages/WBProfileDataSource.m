//
//  WBProfileDataSource.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBProfileDataSource.h"
#import "WBProfilePersonCell.h"

@implementation WBProfileDataSource

- (void)setup
{
  [super setup];

  [self registerNib:[WBProfilePersonCell class]];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  WBProfilePersonCell *cell = [tableView tk_dequeueReusableCellWithClass:[WBProfilePersonCell class]];
  return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
