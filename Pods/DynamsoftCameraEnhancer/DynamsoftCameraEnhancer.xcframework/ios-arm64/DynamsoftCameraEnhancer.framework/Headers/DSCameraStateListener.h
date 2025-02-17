/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCameraEnhancer/DSCameraState.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The protocol that includes methods for monitoring the camera state.
 */
NS_SWIFT_NAME(CameraStateListener)
@protocol DSCameraStateListener <NSObject>

/**
 * The method for monitoring the camera state and receiving call.
 *
 * @param currentState The current camera state.
 */
- (void)onCameraStateChanged:(DSCameraState)currentState;

@end

NS_ASSUME_NONNULL_END
