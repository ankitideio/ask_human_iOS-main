/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCapabilities defines the capability properties of the hardware.
 */
NS_SWIFT_NAME(Capabilities)
@interface DSCapabilities : NSObject
/**
 * Get the maximum zoom factor.
 */
@property (nonatomic, assign, readonly) CGFloat maxZoomFactor;
/**
 * Get the maximum focal length.
 */
@property (nonatomic, assign, readonly) CGFloat minFocusLength;
/**
 * Get the maximum focal length.
 */
@property (nonatomic, assign, readonly) CGFloat maxFocusLength;
/**
 * Get the minimum exposure time.
 */
@property (nonatomic, assign, readonly) CMTime minExposureTime;
/**
 * Get the maximum exposure time.
 */
@property (nonatomic, assign, readonly) CMTime maxExposureTime;
/**
 * Get the minimum ISO.
 */
@property (nonatomic, assign, readonly) CGFloat minISO;
/**
 * Get the maximum ISO.
 */
@property (nonatomic, assign, readonly) CGFloat maxISO;

@end

NS_ASSUME_NONNULL_END
