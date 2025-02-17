/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCaptureVisionRouterModule class defines general functions of the capture vision router module..
 */
NS_SWIFT_NAME(CaptureVisionRouterModule)
@interface DSCaptureVisionRouterModule : NSObject

/**
 * Get the version of Dynamsoft Capture Vision
 *
 * @return The version of Dynamsoft Capture Vision.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
