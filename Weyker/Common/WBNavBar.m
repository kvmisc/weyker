//
//  WBNavBar.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBNavBar.h"

#define MIN_BTN_WID 40.0
#define MAX_BTN_WID 50.0

@implementation WBNavBar

- (void)setup
{
  self.backgroundColor = [UIColor yellowColor];
}


- (void)setupBackBtn
{
  [self removeLeftBtn];
  [self removeLeftView];

  _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [_backBtn setTitleColor:[UIColor tk_colorWithHexInteger:kWBNavBarButtonTextColor] forState:UIControlStateNormal];
  _backBtn.titleLabel.font = [UIFont systemFontOfSize:kWBNavBarButtonFontSize];
  [_backBtn setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
  [_backBtn setImage:[UIImage imageNamed:@"navbar_back_highlighted"] forState:UIControlStateHighlighted];
  [_backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_backBtn];
}

- (void)setupLeftBtn
{
  [self removeBackBtn];
  [self removeLeftBtn];
  [self removeLeftView];

  _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [_leftBtn setTitleColor:[UIColor tk_colorWithHexInteger:kWBNavBarButtonTextColor] forState:UIControlStateNormal];
  _leftBtn.titleLabel.font = [UIFont systemFontOfSize:kWBNavBarButtonFontSize];
  [_leftBtn addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_leftBtn];
}
- (void)setLeftView:(UIView *)leftView
{
  if ( leftView ) {
    [self removeBackBtn];
    [self removeLeftBtn];
    [self removeLeftView];
    _leftView = leftView;
    [self addSubview:_leftView];
  } else {
    [self removeLeftView];
  }
}

- (void)setupTitleLabel
{
  [self removeTitleView];

  _titleLabel = [[UILabel alloc] init];
  _titleLabel.font = [UIFont systemFontOfSize:kWBNavBarTitleFontSize];
  _titleLabel.textColor = [UIColor tk_colorWithHexInteger:kWBNavBarTitleTextColor];
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _titleLabel.numberOfLines = 1;
  _titleLabel.backgroundColor = [UIColor clearColor];
  _titleLabel.adjustsFontSizeToFitWidth = NO;
  [self addSubview:_titleLabel];
}
- (void)setTitleView:(UIView *)titleView
{
  if ( titleView ) {
    [self removeTitleLabel];
    [self removeTitleView];
    _titleView = titleView;
    [self addSubview:_titleView];
  } else {
    [self removeTitleView];
  }
}

- (void)setupRightBtn
{
  [self removeRightBtn];
  [self removeRightView];

  _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [_rightBtn setTitleColor:[UIColor tk_colorWithHexInteger:kWBNavBarButtonTextColor] forState:UIControlStateNormal];
  _rightBtn.titleLabel.font = [UIFont systemFontOfSize:kWBNavBarButtonFontSize];
  [_rightBtn addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_rightBtn];
}
- (void)setRightView:(UIView *)rightView
{
  if ( rightView ) {
    [self removeRightBtn];
    [self removeRightView];
    _rightView = rightView;
    [self addSubview:_rightView];
  } else {
    [self removeRightView];
  }
}

#pragma mark - Private methods

- (void)removeBackBtn     { [_backBtn removeFromSuperview];     _backBtn = nil; }
- (void)removeLeftBtn     { [_leftBtn removeFromSuperview];     _leftBtn = nil; }
- (void)removeLeftView    { [_leftView removeFromSuperview];    _leftView = nil; }
- (void)removeTitleLabel  { [_titleLabel removeFromSuperview];  _titleLabel = nil; }
- (void)removeTitleView   { [_titleView removeFromSuperview];   _titleView = nil; }
- (void)removeRightBtn    { [_rightBtn removeFromSuperview];    _rightBtn = nil; }
- (void)removeRightView   { [_rightView removeFromSuperview];   _rightView = nil; }


- (void)backButtonClicked:(UIButton *)btn
{
  NSLog(@"back clicked");
}

- (void)leftButtonClicked:(UIButton *)btn
{
  NSLog(@"left clicked");
}

- (void)rightButtonClicked:(UIButton *)btn
{
  NSLog(@"right clicked");
}


- (CGSize)intrinsicContentSize
{
  return CGSizeMake(UIViewNoIntrinsicMetric, kWBRootTabBarHeight);
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  _backBtn.frame = CGRectMake(0.0,
                              self.bounds.size.height-kWBNavBarHeight,
                              MAX_BTN_WID,
                              kWBNavBarHeight);

  _leftBtn.frame = CGRectMake(0.0,
                              self.bounds.size.height-kWBNavBarHeight,
                              MAX_BTN_WID,
                              kWBNavBarHeight);

  _titleLabel.frame = CGRectMake(MAX_BTN_WID,
                                 self.bounds.size.height-kWBNavBarHeight,
                                 self.bounds.size.width-2*MAX_BTN_WID,
                                 kWBNavBarHeight);

  _rightBtn.frame = CGRectMake(self.bounds.size.width-MAX_BTN_WID,
                               self.bounds.size.height-kWBNavBarHeight,
                               MAX_BTN_WID,
                               kWBNavBarHeight);
}

@end
