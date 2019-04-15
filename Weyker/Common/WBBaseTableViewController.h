//
//  WBBaseTableViewController.h
//  GenericProj
//
//  Created by Kevin Wu on 9/8/17.
//  Copyright © 2017 firefly.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBBaseTableViewCell.h"

@interface WBBaseTableViewController : WBBaseViewController <
    UITableViewDataSource,
    UITableViewDelegate
>

@end
