//
//  XYZBaseTableViewCell.h
//  GenericProj
//
//  Created by Haiping Wu on 2018/4/13.
//  Copyright © 2018 firefly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *aboveLine;
@property (nonatomic, strong) UIView *belowLine;

- (void)configLine:(NSInteger)index count:(NSInteger)count;

@end
