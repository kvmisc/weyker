//
//  WBRootToolBar.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBRootToolBar.h"

@implementation WBRootToolBar

- (CGSize)intrinsicContentSize
{
  return CGSizeMake(UIViewNoIntrinsicMetric, kWBRootTabBarHeight);
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  for ( UIView *subview in self.subviews ) {
    subview.frame = self.bounds;
  }
}

@end
