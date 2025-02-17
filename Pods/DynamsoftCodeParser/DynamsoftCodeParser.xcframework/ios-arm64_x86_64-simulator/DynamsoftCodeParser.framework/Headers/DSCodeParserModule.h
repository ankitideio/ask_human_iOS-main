/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Code Parser module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCodeParserModule class defines general functions of the code parser module.
 */
NS_SWIFT_NAME(CodeParserModule)
@interface DSCodeParserModule : NSObject

/**
 * Get the version of Dynamsoft Code Parser
 *
 * @return The version of Dynamsoft Code Parser.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
