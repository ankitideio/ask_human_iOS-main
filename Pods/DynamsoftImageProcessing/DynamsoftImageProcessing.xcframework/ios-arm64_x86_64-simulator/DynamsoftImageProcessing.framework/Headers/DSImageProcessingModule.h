/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Image Processing module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSImageProcessingModule class defines general functions of the image processing module.
 */
NS_SWIFT_NAME(ImageProcessingModule)
@interface DSImageProcessingModule : NSObject

/**
 * Get the version of Dynamsoft Image Processing module.
 *
 * @return The version of Dynamsoft Image Processing module.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
