//
//  WBRootViewController.h
//  Weyker
//
//  Created by Haiping Wu on 2019/4/15.
//  Copyright © 2019 migu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBHomeViewController.h"
#import "WBDiscoverViewController.h"
#import "WBMessageViewController.h"
#import "WBProfileViewController.h"

@interface WBRootViewController : UIViewController

@property (nonatomic, strong, readonly) WBHomeViewController *homeViewController;
@property (nonatomic, strong, readonly) WBDiscoverViewController *discoverViewController;
@property (nonatomic, strong, readonly) WBMessageViewController *messageViewController;
@property (nonatomic, strong, readonly) WBProfileViewController *profileViewController;

@end
