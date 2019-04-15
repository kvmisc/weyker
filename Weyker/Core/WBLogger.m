//
//  WBLogger.m
//  GenericProj
//
//  Created by Kevin Wu on 8/8/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

#import "WBLogger.h"

@implementation WBLogger

+ (void)setup
{
  DDTTYLogger *TTYLogger = [DDTTYLogger sharedInstance];
  [DDLog addLogger:TTYLogger];

  //DDASLLogger *ASLLogger = [DDASLLogger sharedInstance];
  //[DDLog addLogger:ASLLogger];

  DDFileLogger *FileLogger = [[DDFileLogger alloc] init];
  FileLogger.rollingFrequency = 60*60*24;
  FileLogger.logFileManager.maximumNumberOfLogFiles = 7;
  [DDLog addLogger:FileLogger];
}

@end
