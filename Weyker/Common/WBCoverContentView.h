//
//  WBCoverContentView.h
//  GenericProj
//
//  Created by Haiping Wu on 2019/4/12.
//  Copyright © 2019 firefly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBCoverView;


@interface WBCoverContentView : UIView

@property (nonatomic, weak, readonly) WBCoverView *coverView;

- (void)prepareForView:(UIView *)inView viewport:(UIView *)viewport;

- (void)updateStateFromAnimation:(BOOL)completion;

- (CAAnimation *)showAnimation;
- (CAAnimation *)hideAnimation;

@end
