//
//  WBMessageCenter.m
//  GenericProj
//
//  Created by Kevin Wu on 14/12/2017.
//  Copyright © 2017 firefly.com. All rights reserved.
//

#import "WBMessageCenter.h"

@implementation WBMC

+ (WBCoverView *)ATV:(UIView *)inView
{ return [self ATV:inView viewport:nil complete:NULL]; }
+ (WBCoverView *)ATV:(UIView *)inView complete:(void (^)(void))complete
{ return [self ATV:inView viewport:nil complete:complete]; }
+ (WBCoverView *)ATV:(UIView *)inView viewport:(UIView *)viewport complete:(void (^)(void))complete
{
  return [self presentHUDInView:inView
                       activity:YES
                           text:nil
                         cancel:NULL
                       viewport:viewport
                       complete:complete];
}

+ (WBCoverView *)TXT:(UIView *)inView text:(NSString *)text
{ return [self TXT:inView text:text viewport:nil complete:NULL]; }
+ (WBCoverView *)TXT:(UIView *)inView text:(NSString *)text complete:(void (^)(void))complete
{ return [self TXT:inView text:text viewport:nil complete:complete]; }
+ (WBCoverView *)TXT:(UIView *)inView text:(NSString *)text viewport:(UIView *)viewport complete:(void (^)(void))complete
{
  return [self presentHUDInView:inView
                       activity:YES
                           text:text
                         cancel:NULL
                       viewport:viewport
                       complete:complete];
}

+ (WBCoverView *)CCL:(UIView *)inView text:(NSString *)text cancel:(void (^)(void))cancel
{ return [self CCL:inView text:text cancel:cancel viewport:nil complete:NULL]; }
+ (WBCoverView *)CCL:(UIView *)inView text:(NSString *)text cancel:(void (^)(void))cancel complete:(void (^)(void))complete
{ return [self CCL:inView text:text cancel:cancel viewport:nil complete:complete]; }
+ (WBCoverView *)CCL:(UIView *)inView text:(NSString *)text cancel:(void (^)(void))cancel viewport:(UIView *)viewport complete:(void (^)(void))complete
{
  return [self presentHUDInView:inView
                       activity:YES
                           text:text
                         cancel:cancel
                       viewport:viewport
                       complete:complete];
}

+ (WBCoverView *)INF:(UIView *)inView info:(NSString *)info
{ return [self INF:inView info:info viewport:nil complete:NULL]; }
+ (WBCoverView *)INF:(UIView *)inView info:(NSString *)info complete:(void (^)(void))complete
{ return [self INF:inView info:info viewport:nil complete:complete]; }
+ (WBCoverView *)INF:(UIView *)inView info:(NSString *)info viewport:(UIView *)viewport complete:(void (^)(void))complete
{
  WBCoverView *coverView = [self presentHUDInView:inView
                                          activity:NO
                                              text:info
                                            cancel:NULL
                                          viewport:viewport
                                          complete:complete];
  [coverView hide:YES afterDelay:3.0];
  return coverView;
}

static UIWindow *LastVisibleTopmostWindow = nil;

+ (WBCoverView *)presentHUDInView:(UIView *)inView
                          activity:(BOOL)activity
                              text:(NSString *)text
                            cancel:(void (^)(void))cancel
                          viewport:(UIView *)viewport
                          complete:(void (^)(void))complete
{
  if ( !inView ) {
    UIWindow *window = [WBGlobal visibleTopmostWindow];
    if ( window!=LastVisibleTopmostWindow ) {
      // 如果最新的顶端窗口与上次的不同，隐藏旧窗口里面的 HUD
      [self hideHUD:LastVisibleTopmostWindow];
    }
    // 以前得到的窗口有可能已经不处于最顶端、有可能是隐藏状态，更新顶端窗口
    LastVisibleTopmostWindow = window;
    inView = window;
  }

  WBCoverView *coverView = [self HUDInView:inView];
  WBHUDView *hud = nil;
  if ( coverView ) {
    hud = (WBHUDView *)(coverView.contentView);
    [hud prepareForView:inView viewport:viewport];
  } else {
    hud = [[WBHUDView alloc] init];
    [hud prepareForView:inView viewport:viewport];
    coverView = hud.coverView;
  }

  [hud configWithActivity:activity text:text cancel:cancel];

  coverView.touchBackgroundToHide = NO;

  coverView.completion = complete;

  [coverView show:YES];

  return coverView;
}


+ (void)hideHUD:(UIView *)inView
{
  [self hideHUD:inView animated:YES delay:0.0];
}
+ (void)hideHUD:(UIView *)inView delay:(NSTimeInterval)delay
{
  [self hideHUD:inView animated:YES delay:delay];
}
+ (void)hideHUD:(UIView *)inView animated:(BOOL)animated
{
  [self hideHUD:inView animated:animated delay:0.0];
}
+ (void)hideHUD:(UIView *)inView animated:(BOOL)animated delay:(NSTimeInterval)delay
{
  WBCoverView *coverView = [self HUDInView:inView?:LastVisibleTopmostWindow];
  [coverView hide:animated afterDelay:delay];
}


+ (WBCoverView *)HUDInView:(UIView *)inView
{
  if ( inView ) {
    for ( UIView *sub1 in inView.subviews ) {
      if ( [sub1 isKindOfClass:[WBCoverView class]] ) {

        for ( UIView *sub2 in sub1.subviews ) {
          if ( [sub2 isKindOfClass:[WBHUDView class]] ) {
            return (WBCoverView *)sub1;
          }
        }

      }
    }
  }
  return nil;
}

@end
