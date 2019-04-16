//
//  WBRootTabBar.m
//  Weyker
//
//  Created by Haiping Wu on 2019/4/16.
//  Copyright © 2019 migu. All rights reserved.
//

#import "WBRootTabBar.h"

@interface WBRootTabBar ()
@property (nonatomic, strong) UIButton *tab1;
@property (nonatomic, strong) UIButton *tab2;
@property (nonatomic, strong) UIButton *tab3;
@property (nonatomic, strong) UIButton *tab4;
@end

@implementation WBRootTabBar

- (void)setup
{
  _tab1 = [UIButton buttonWithType:UIButtonTypeCustom];
  [_tab1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [_tab1.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
  [self addSubview:_tab1];
}

@end
