//
//  WBDateFormatter.h
//  SmartCombat
//
//  Created by Kevin Wu on 11/12/2017.
//  Copyright © 2017 Kevin Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

// yyyy-MM-dd HH:mm:ss
extern NSDateFormatter *WBDateFormatter01;

// yyyy-MM-dd
extern NSDateFormatter *WBDateFormatter21;
// yyyy-MM
extern NSDateFormatter *WBDateFormatter22;

// HH:mm:ss
extern NSDateFormatter *WBDateFormatter41;


@interface WBDateFormatter : NSObject

+ (void)setup;

@end
