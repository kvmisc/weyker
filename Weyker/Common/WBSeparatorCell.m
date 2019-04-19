//
//  WBSeparatorCell.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/19.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBSeparatorCell.h"

@implementation WBSeparatorCell {
  CALayer *_topSeparator;
  CALayer *_bottomSeparator;
}

- (void)configSeparator:(NSInteger)index count:(NSInteger)count
{
  if ( index==0 ) {
    if ( !_topSeparator ) {
      _topSeparator = [CALayer layer];
      [self.layer addSublayer:_topSeparator];
    }
    _topSeparator.zPosition = 100.0;
    _topSeparator.backgroundColor = [[UIColor redColor] CGColor];
  } else {
    [_topSeparator removeFromSuperlayer];
    _topSeparator = nil;
  }

  if ( !_bottomSeparator ) {
    _bottomSeparator = [CALayer layer];
    [self.layer addSublayer:_bottomSeparator];
  }
  _bottomSeparator.zPosition = 100.0;
  _bottomSeparator.backgroundColor = [[UIColor blueColor] CGColor];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  _topSeparator.frame = CGRectMake(0.0,
                                   0.0,
                                   self.layer.bounds.size.width,
                                   1.0/[[UIScreen mainScreen] scale]);

  _bottomSeparator.frame = CGRectMake(0.0,
                                      self.layer.bounds.size.height-0.5,
                                      self.layer.bounds.size.width,
                                      1.0/[[UIScreen mainScreen] scale]);
}

@end
