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
- (void)setupTitleLabel; // 一般都会有标题，此项默认调用
- (void)setupRightBtn;

// 长字符串显示在导航栏会让样子很糟，这里的 length 是字符数，返回的字符串长度为 length+1
// "取消收藏" -> "取消…"
// "取消" -> "取消"
+ (NSString *)truncateText:(NSString *)text toLength:(NSUInteger)length;

@end
