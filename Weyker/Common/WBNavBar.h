//
//  WBNavBar.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/17.
//  Copyright © 2019 migu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBNavBar : WBBaseView

@property (nonatomic, strong, readonly) UIButton *backBtn;
@property (nonatomic, strong, readonly) UIButton *leftBtn;
@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong, readonly) UIButton *rightBtn;
@property (nonatomic, strong) UIView *rightView;

- (void)setupBackBtn;
- (void)setupLeftBtn;
- (void)setupTitleLabel;
- (void)setupRightBtn;

@end
