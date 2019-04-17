//
//  WBRootTabBar.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/16.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBRootTabBar.h"

@interface WBRootTabBar ()
@property (nonatomic, strong) NSArray *tabAry;
@end

@implementation WBRootTabBar

- (void)setup
{
  self.backgroundColor = [UIColor whiteColor];

  UIButton *tab1 = [UIButton buttonWithType:UIButtonTypeCustom];
  tab1.tag = 0;
  [tab1 setTitleColor:[UIColor tk_colorWithHexInteger:kWBRootTabBarTextColor] forState:UIControlStateNormal];
  tab1.titleLabel.font = [UIFont systemFontOfSize:kWBRootTabBarFontSize];
  [tab1 setTitle:NSLocalizedString(@"微博", @"") forState:UIControlStateNormal];
  [tab1 setImage:[UIImage imageNamed:@"tabbar_home"] forState:UIControlStateNormal];
  [tab1 setImage:[UIImage imageNamed:@"tabbar_home_selected"] forState:UIControlStateSelected];
  [tab1 setImage:[UIImage imageNamed:@"tabbar_home_highlighted"] forState:UIControlStateHighlighted];
  [tab1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:tab1];

  UIButton *tab2 = [UIButton buttonWithType:UIButtonTypeCustom];
  tab2.tag = 1;
  [tab2 setTitleColor:[UIColor tk_colorWithHexInteger:kWBRootTabBarTextColor] forState:UIControlStateNormal];
  tab2.titleLabel.font = [UIFont systemFontOfSize:kWBRootTabBarFontSize];
  [tab2 setTitle:NSLocalizedString(@"发现", @"") forState:UIControlStateNormal];
  [tab2 setImage:[UIImage imageNamed:@"tabbar_discover"] forState:UIControlStateNormal];
  [tab2 setImage:[UIImage imageNamed:@"tabbar_discover_selected"] forState:UIControlStateSelected];
  [tab2 setImage:[UIImage imageNamed:@"tabbar_discover_highlighted"] forState:UIControlStateHighlighted];
  [tab2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:tab2];

  UIButton *tab3 = [UIButton buttonWithType:UIButtonTypeCustom];
  tab3.tag = 2;
  [tab3 setTitleColor:[UIColor tk_colorWithHexInteger:kWBRootTabBarTextColor] forState:UIControlStateNormal];
  tab3.titleLabel.font = [UIFont systemFontOfSize:kWBRootTabBarFontSize];
  [tab3 setTitle:NSLocalizedString(@"消息", @"") forState:UIControlStateNormal];
  [tab3 setImage:[UIImage imageNamed:@"tabbar_message"] forState:UIControlStateNormal];
  [tab3 setImage:[UIImage imageNamed:@"tabbar_message_selected"] forState:UIControlStateSelected];
  [tab3 setImage:[UIImage imageNamed:@"tabbar_message_highlighted"] forState:UIControlStateHighlighted];
  [tab3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:tab3];

  UIButton *tab4 = [UIButton buttonWithType:UIButtonTypeCustom];
  tab4.tag = 3;
  [tab4 setTitleColor:[UIColor tk_colorWithHexInteger:kWBRootTabBarTextColor] forState:UIControlStateNormal];
  tab4.titleLabel.font = [UIFont systemFontOfSize:kWBRootTabBarFontSize];
  [tab4 setTitle:NSLocalizedString(@"我", @"") forState:UIControlStateNormal];
  [tab4 setImage:[UIImage imageNamed:@"tabbar_profile"] forState:UIControlStateNormal];
  [tab4 setImage:[UIImage imageNamed:@"tabbar_profile_selected"] forState:UIControlStateSelected];
  [tab4 setImage:[UIImage imageNamed:@"tabbar_profile_highlighted"] forState:UIControlStateHighlighted];
  [tab4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:tab4];

  _tabAry = @[tab1, tab2, tab3, tab4];

  _selectedIndex = 0;
  [self updatePage];

  _shouldNotifyRepeatedly = NO;
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  NSInteger tabCount = _tabAry.count;
  CGFloat tabWidth = WB_SCREEN_WID/tabCount;

  for ( NSInteger i=0; i<tabCount; ++i ) {
    UIButton *tab = [_tabAry objectAtIndex:i];
    tab.frame = CGRectIntegral(CGRectMake(i*tabWidth, 0.0, tabWidth, kWBRootTabBarHeight));
    [tab tk_centerVertically:0.0];
  }
}

//- (CGSize)intrinsicContentSize
//{
//  return CGSizeMake(UIViewNoIntrinsicMetric, kWBRootTabBarHeight);
//}

- (void)buttonClicked:(UIButton *)btn
{
  NSUInteger idx = btn.tag;
  if ( [self isIndexValid:idx] ) {
    NSUInteger oldIndex = _selectedIndex;
    _selectedIndex = idx;
    [self updatePage];
    if ( (_shouldNotifyRepeatedly) || (_selectedIndex!=oldIndex) ) {
      if ( _didSelect ) {
        _didSelect(_selectedIndex);
      }
    }
  }
}

- (void)setSelectedIndex:(NSUInteger)idx
{
  if ( [self isIndexValid:idx] ) {
    _selectedIndex = idx;
    [self updatePage];
  }
}

- (void)updatePage
{
  for ( UIButton *btn in _tabAry ) {
    [btn setSelected:(btn.tag==_selectedIndex)];
  }
}

- (BOOL)isIndexValid:(NSUInteger)idx
{
  return ( (idx>=0) && (idx<[_tabAry count]) );
}

@end
