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

// 图标宽度
#define BACK_POP_WID 16.0
#define BACK_DISMISS_WID 30.0


@implementation WBNavBar

- (void)setup
{
  self.backgroundColor = [UIColor whiteColor];

  [self setupLeftBtn];
  [self setupTitleLabel];
  [self setupRightBtn];
}

#pragma mark - Accessors

- (void)setLeftView:(UIView *)leftView
{
  if ( leftView ) {
    _leftBtn.hidden = YES;
    [self removeLeftView];
    _leftView = leftView;
    [self addSubview:_leftView];
  } else {
    [self removeLeftView];
  }
}
- (void)setTitleView:(UIView *)titleView
{
  if ( titleView ) {
    _titleLabel.hidden = YES;
    [self removeTitleView];
    _titleView = titleView;
    [self addSubview:_titleView];
  } else {
    [self removeTitleView];
  }
}
- (void)setRightView:(UIView *)rightView
{
  if ( rightView ) {
    _rightBtn.hidden = YES;
    [self removeRightView];
    _rightView = rightView;
    [self addSubview:_rightView];
  } else {
    [self removeRightView];
  }
}

#pragma mark - Public methods

- (void)setupPopBtn
{
  [self removeLeftView];

  [_leftBtn setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
  [_leftBtn setTitle:nil forState:UIControlStateNormal];

  _leftBtn.hidden = NO;
}
- (void)setupDismissBtn
{
  [self removeLeftView];

  [_leftBtn setImage:[UIImage imageNamed:@"navbar_close"] forState:UIControlStateNormal];
  [_leftBtn setTitle:nil forState:UIControlStateNormal];

  _leftBtn.hidden = NO;
}
- (void)setupLeftBtn
{
  [self removeLeftView];

  if ( !_leftBtn ) {
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setTitleColor:[UIColor tk_colorWithHexInteger:kWBNavBarButtonTextColor] forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:kWBNavBarButtonFontSize];
    [self addSubview:_leftBtn];
  }

  _leftBtn.hidden = NO;
}
- (void)setupTitleLabel
{
  [self removeTitleView];

  if ( !_titleLabel ) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:kWBNavBarTitleFontSize];
    _titleLabel.textColor = [UIColor tk_colorWithHexInteger:kWBNavBarTitleTextColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.adjustsFontSizeToFitWidth = NO;
    _titleLabel.numberOfLines = 1;
    _titleLabel.tag = 101;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
  }

  _titleLabel.hidden = NO;
}
- (void)setupRightBtn
{
  [self removeRightView];

  if ( !_rightBtn ) {
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitleColor:[UIColor tk_colorWithHexInteger:kWBNavBarButtonTextColor] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:kWBNavBarButtonFontSize];
    [self addSubview:_rightBtn];
  }

  _rightBtn.hidden = NO;
}

+ (NSString *)truncateText:(NSString *)text toLength:(NSUInteger)length
{
  if ( text.length>length ) {
    return [NSString stringWithFormat:@"%@…", [text substringToIndex:length]];
  }
  return text;
}

#pragma mark - Private methods

- (void)removeLeftView
{
  [_leftView removeFromSuperview];
  _leftView = nil;
}
- (void)removeTitleView
{
  [_titleView removeFromSuperview];
  _titleView = nil;
}
- (void)removeRightView
{
  [_rightView removeFromSuperview];
  _rightView = nil;
}

#pragma mark - Metrics

- (CGSize)intrinsicContentSize
{
  return CGSizeMake(UIViewNoIntrinsicMetric, kWBNavBarHeight);
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  CGFloat selfWidth = self.bounds.size.width;
  CGFloat selfHeight = self.bounds.size.height;

  // 根据前后用量来算标题位置
  CGFloat frntUsage = 0.0;
  CGFloat backUsage = 0.0;

  if ( _leftBtn ) {
    CGSize contentSize = [_leftBtn intrinsicContentSize];
    if ( contentSize.width<=BACK_POP_WID ) {
      // 此时应该是不带文字的返回按钮，按钮要加宽
      _leftBtn.frame = CGRectMake(0.0,
                                  selfHeight-kWBNavBarHeight,
                                  ceil(contentSize.width+2*SCREEN_PADDING),
                                  kWBNavBarHeight);
      frntUsage = ceil(contentSize.width);
    } else {
      // 此时可能是带文字的返回按钮、关闭按钮、图标按钮或文字按钮
      _leftBtn.frame = CGRectMake(SCREEN_PADDING,
                                  selfHeight-kWBNavBarHeight,
                                  ceil(contentSize.width),
                                  kWBNavBarHeight);
      frntUsage = SCREEN_PADDING + ceil(contentSize.width);
    }
  }
  if ( _leftView ) {
    CGSize contentSize = [_leftView intrinsicContentSize];
    _leftView.frame = CGRectMake(SCREEN_PADDING,
                                 floor(selfHeight-(kWBNavBarHeight-contentSize.height)/2.0-contentSize.height),
                                 contentSize.width,
                                 contentSize.height);
    frntUsage = SCREEN_PADDING + contentSize.width;
  }

  if ( _rightBtn ) {
    CGSize contentSize = [_rightBtn intrinsicContentSize];
    _rightBtn.frame = CGRectMake(floor(selfWidth-contentSize.width-SCREEN_PADDING),
                                 selfHeight-kWBNavBarHeight,
                                 ceil(contentSize.width),
                                 kWBNavBarHeight);
    backUsage = ceil(contentSize.width) + SCREEN_PADDING;
  }
  if ( _rightView ) {
    CGSize contentSize = [_rightView intrinsicContentSize];
    _rightView.frame = CGRectMake(selfWidth-contentSize.width-SCREEN_PADDING,
                                  floor(selfHeight-(kWBNavBarHeight-contentSize.height)/2.0-contentSize.height),
                                  contentSize.width,
                                  contentSize.height);
    backUsage = contentSize.width + SCREEN_PADDING;
  }

  // titleLabel 会根据前后用量来压缩，不会根据自己尺寸来布局
  CGFloat titleMargin = MAX(frntUsage, backUsage) + CONTENT_SPACING;
  _titleLabel.frame = CGRectMake(titleMargin,
                                 selfHeight-kWBNavBarHeight,
                                 selfWidth-2*titleMargin,
                                 kWBNavBarHeight);
  // titleView 啥也不管，给多大就显示多大
  CGSize contentSize = [_titleView intrinsicContentSize];
  _titleView.frame = CGRectMake(floor((selfWidth-contentSize.width)/2.0),
                                floor(selfHeight-kWBNavBarHeight+(kWBNavBarHeight-contentSize.width)/2.0),
                                ceil(contentSize.width),
                                ceil(contentSize.height));
}

@end
