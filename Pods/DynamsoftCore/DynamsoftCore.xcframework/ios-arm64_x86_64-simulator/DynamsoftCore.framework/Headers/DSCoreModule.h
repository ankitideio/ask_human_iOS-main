/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, DSLogMode) {
    
    DSLogModeConsole = 1 << 0,
    
    DSLogModeFile = 1 << 1
} NS_SWIFT_NAME(LogMode);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(CoreModule)
@interface DSCoreModule : NSObject
/**
 * Get the version of Dynamsoft Core
 *
 * @return The version of Dynamsoft Core.
 */
+ (NSString *)getVersion;

/**
 * Enable the output of algorithm logs.
 * @param [in] mode The log mode. You can output log info in the console, log file, or both.
 */
+ (void)enableLogging:(DSLogMode)mode;

/**
 * Disable the output of algorithm logs.
 */
+ (void)disableLogging;

@end

NS_ASSUME_NONNULL_END
