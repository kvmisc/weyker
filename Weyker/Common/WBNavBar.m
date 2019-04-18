//
//  WBNavBar.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBNavBar.h"

// 屏幕左右的间隙
#define SCREEN_PADDING 10.0
// 按钮和标题的间隙
#define CONTENT_SPACING 5.0

// 返回图片宽度
#define BACK_IMG_WID 16.0


#define MIN_BTN_WID 40.0
#define MAX_BTN_WID 50.0

// 返回按钮，"个人…"
#define BTN_WID_BACK_LONG 56
// 返回按钮，"主页"
#define BTN_WID_BACK_TXT 45
// 返回按钮，""
#define BTN_WID_BACK_IMG 16

// 文字按钮，"取消…"
#define BTN_WID_LONG 40
// 文字按钮，"完成"
#define BTN_WID_TXT 30

@implementation WBNavBar

- (void)setup
{
  self.backgroundColor = [UIColor yellowColor];

  [self setupTitleLabel];
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
  _titleLabel.font = [UIFont boldSystemFontOfSize:kWBNavBarTitleFontSize];
  _titleLabel.textColor = [UIColor tk_colorWithHexInteger:kWBNavBarTitleTextColor];
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  _titleLabel.adjustsFontSizeToFitWidth = NO;
  _titleLabel.numberOfLines = 1;
  _titleLabel.backgroundColor = [UIColor clearColor];
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

+ (NSString *)truncateText:(NSString *)text toLength:(NSUInteger)length
{
  if ( text.length>length ) {
    return [NSString stringWithFormat:@"%@…", [text substringToIndex:length]];
  }
  return text;
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

  // 根据前后用量来算标题位置
  CGFloat frntUsage = 0.0;
  CGFloat backUsage = 0.0;

  if ( _backBtn ) {
    [_backBtn sizeToFit];
    if ( _backBtn.bounds.size.width<=BACK_IMG_WID ) {
      // 此时的返回按钮应该只有图片，图片太窄，按钮要加宽
      _backBtn.frame = CGRectMake(0.0,
                                  self.bounds.size.height-kWBNavBarHeight,
                                  _backBtn.bounds.size.width+2*SCREEN_PADDING,
                                  kWBNavBarHeight);
      frntUsage = _backBtn.bounds.size.width;
    } else {
      _backBtn.frame = CGRectMake(SCREEN_PADDING,
                                  self.bounds.size.height-kWBNavBarHeight,
                                  _backBtn.bounds.size.width,
                                  kWBNavBarHeight);
      frntUsage = SCREEN_PADDING + _backBtn.bounds.size.width;
    }
  }
  if ( _leftBtn ) {
    [_leftBtn sizeToFit];
    _leftBtn.frame = CGRectMake(SCREEN_PADDING,
                                self.bounds.size.height-kWBNavBarHeight,
                                _leftBtn.bounds.size.width,
                                kWBNavBarHeight);
    frntUsage = SCREEN_PADDING + _leftBtn.bounds.size.width;
  }
  if ( _leftView ) {
    CGSize contentSize = [_leftView intrinsicContentSize];
    _leftView.frame = CGRectMake(SCREEN_PADDING,
                                 floor(self.bounds.size.height-(kWBNavBarHeight-contentSize.height)/2.0-contentSize.height),
                                 contentSize.width,
                                 contentSize.height);
    frntUsage = SCREEN_PADDING + contentSize.width;
  }

  if ( _rightBtn ) {
    [_rightBtn sizeToFit];
    _rightBtn.frame = CGRectMake(self.bounds.size.width-_rightBtn.bounds.size.width-SCREEN_PADDING,
                                 self.bounds.size.height-kWBNavBarHeight,
                                 _rightBtn.bounds.size.width,
                                 kWBNavBarHeight);
    backUsage = _rightBtn.bounds.size.width + SCREEN_PADDING;
  }
  if ( _rightView ) {
    CGSize contentSize = [_rightView intrinsicContentSize];
    _rightView.frame = CGRectMake(self.bounds.size.width-contentSize.width-SCREEN_PADDING,
                                  floor(self.bounds.size.height-(kWBNavBarHeight-contentSize.height)/2.0-contentSize.height),
                                  contentSize.width,
                                  contentSize.height);
    backUsage = contentSize.width + SCREEN_PADDING;
  }


  // titleLabel 会根据前后用量来压缩
  CGFloat titleMargin = MAX(frntUsage, backUsage) + CONTENT_SPACING;
  _titleLabel.frame = CGRectMake(titleMargin,
                                 self.bounds.size.height-kWBNavBarHeight,
                                 self.bounds.size.width-2*titleMargin,
                                 kWBNavBarHeight);

  // titleView 啥也不管，给多大就显示多大
  [_titleView sizeToFit];
  _titleView.center = CGPointMake(self.center.x, floor(self.bounds.size.height-kWBNavBarHeight/2.0));
}

@end
