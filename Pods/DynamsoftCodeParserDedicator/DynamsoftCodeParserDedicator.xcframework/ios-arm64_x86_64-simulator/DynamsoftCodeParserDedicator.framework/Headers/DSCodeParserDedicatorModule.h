/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Code Parser Dedicator module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCodeParserDedicatorModule class defines general functions of the code parser dedicator module.
 */
NS_SWIFT_NAME(CodeParserDedicatorModule)
@interface DSCodeParserDedicatorModule : NSObject

/**
 * Get the version of Dynamsoft Code Parser Dedicator
 *
 * @return The version of Dynamsoft Code Parser Dedicator.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
