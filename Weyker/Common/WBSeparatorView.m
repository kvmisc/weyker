//
//  WBSeparatorView.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBSeparatorView.h"

@implementation WBSeparatorView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self setup];
  }
  return self;
}

- (void)setup
{
  _separator = [CALayer layer];
  _separator.backgroundColor = [[UIColor lightGrayColor] CGColor];
  [self.layer addSublayer:_separator];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  _separator.frame = CGRectMake(0.0,
                                0.0,
                                self.layer.bounds.size.width,
                                1.0/[[UIScreen mainScreen] scale]);
}

@end
