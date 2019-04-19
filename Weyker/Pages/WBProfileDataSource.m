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
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  WBProfilePersonCell *cell = [tableView tk_dequeueReusableCellWithClass:[WBProfilePersonCell class]];

  NSAttributedString *as1 = [WBProfilePersonCell attributedStringForButton:12 field:WBLS(@"profile_profile_tweets")];
  [cell.tweetsBtn setAttributedTitle:as1 forState:UIControlStateNormal];

  NSAttributedString *as2 = [WBProfilePersonCell attributedStringForButton:13 field:WBLS(@"profile_profile_following")];
  [cell.followingBtn setAttributedTitle:as2 forState:UIControlStateNormal];

  NSAttributedString *as3 = [WBProfilePersonCell attributedStringForButton:14 field:WBLS(@"profile_profile_followers")];
  [cell.followersBtn setAttributedTitle:as3 forState:UIControlStateNormal];

  return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 120.0;
}

@end
