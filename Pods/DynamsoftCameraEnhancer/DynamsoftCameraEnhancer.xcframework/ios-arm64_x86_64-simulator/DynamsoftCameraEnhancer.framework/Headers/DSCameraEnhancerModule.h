/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSCameraEnhancerModule class defines general functions of the camera enhancer module.
 */
NS_SWIFT_NAME(CameraEnhancerModule)
@interface DSCameraEnhancerModule : NSObject

/**
 * Get the version of Dynamsoft Camera Enhancer
 *
 * @return The version of Dynamsoft Camera Enhancer.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
