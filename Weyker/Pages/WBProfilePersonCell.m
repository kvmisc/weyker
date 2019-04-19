//
//  WBProfilePersonCell.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBProfilePersonCell.h"

@implementation WBProfilePersonCell

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.selectionStyle = UITableViewCellSelectionStyleNone;

  _nameLabel.font = [UIFont boldSystemFontOfSize:kWBProfileProfileNameFontSize];
  _nameLabel.textColor = [UIColor tk_colorWithHexInteger:kWBProfileProfileNameTextColor];

  _infoLabel.font = [UIFont systemFontOfSize:kWBProfileProfileInfoFontSize];
  _infoLabel.textColor = [UIColor tk_colorWithHexInteger:kWBProfileProfileInfoTextColor];


  _tweetsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
  _tweetsBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

  _followingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
  _followingBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

  _followersBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
  _followersBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

+ (NSAttributedString *)attributedStringForButton:(NSInteger)count field:(NSString *)field
{
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
  {
    NSString *str = [[NSString alloc] initWithFormat:@"%zd\n", count];
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:str];
    [as setTextColor:[UIColor redColor] range:NSMakeRange(0, str.length-1)];
    [as setFont:[UIFont systemFontOfSize:12] range:NSMakeRange(0, str.length-1)];
    [attributedString appendAttributedString:as];
  }
  {
    NSString *str = field;
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:str];
    [as setTextColor:[UIColor darkGrayColor]];
    [as setFont:[UIFont systemFontOfSize:12]];
    [attributedString appendAttributedString:as];
  }
  return attributedString;
}

@end
