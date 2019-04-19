//
//  WBCoverView.h
//  GenericProj
//
//  Created by Haiping Wu on 2019/4/12.
//  Copyright © 2019 firefly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBBaseView.h"

#import "WBCoverContentView.h"
#import "WBCoverAlertContentView.h"
#import "WBCoverActionContentView.h"

typedef enum : NSUInteger {
  WBCoverViewStatusUnknown = 0,
  WBCoverViewStatusShowing,
  WBCoverViewStatusShowFailed,
  WBCoverViewStatusPresented,
  WBCoverViewStatusHiding,
  WBCoverViewStatusHideFailed,
} WBCoverViewStatus;

@interface WBCoverView : WBBaseView

@property (nonatomic, strong, readonly) UIImageView *backgroundView;
// 点击灰色的遮罩隐藏此视图，默认 YES
@property (nonatomic, assign) BOOL touchBackgroundToHide;

@property (nonatomic, strong) WBCoverContentView *contentView;

@property (nonatomic, assign) WBCoverViewStatus status;
@property (nonatomic, assign, readonly, getter=isShowing) BOOL showing;
@property (nonatomic, assign, readonly, getter=isHiding) BOOL hiding;

// 如果背景是透明的就不需要自身动画来耽误时间，默认 NO
@property (nonatomic, assign) BOOL needsSelfAnimation;

// 完成隐藏的时候调用
@property (nonatomic, copy) void (^completion)(void);


- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


////////////////////////////////////////////////////////////////////////////////

- (void)cancelDelayHide;

// 同步自身状态，不会同步 contentView 的状态
// 只在显示动画或隐藏动画期间有作用，参数为 YES 时直接设置成最终状态，否则同步动画的状态
- (void)updateStateFromAnimation:(BOOL)completion;

- (void)removeAllAnimations;

@end
