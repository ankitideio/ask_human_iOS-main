/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * DSCameraState defines the enumerations that indicates the camera state.
 */
typedef NS_CLOSED_ENUM(NSUInteger, DSCameraState) {
/**
     * The camera is opening.
     */
    DSCameraStateOpening,
/**
     * The camera is opened.
     */
    DSCameraStateOpened,
/**
     * The camera is closing.
     */
    DSCameraStateClosing,
/**
     * The camera is closed.
     */
    DSCameraStateClosed
} NS_SWIFT_NAME(CameraState);
