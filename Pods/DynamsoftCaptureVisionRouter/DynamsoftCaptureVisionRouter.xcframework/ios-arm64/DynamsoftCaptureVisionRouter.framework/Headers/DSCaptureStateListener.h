/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * DSCaptureState defines the enumerations that indicates the capture states.
 */
typedef NS_ENUM(NSInteger, DSCaptureState)
{
    /**
     * The capture is started.
     */
    DSCaptureStateStarted,
    /**
     * The capture is stopped.
     */
    DSCaptureStateStopped,
    /**
        * The capture is paused.
        */
    DSCaptureStatePaused
} NS_SWIFT_NAME(CaptureState);

/**
 * The protocol that defines the methods for monitoring the capture state.
 */
NS_SWIFT_NAME(CaptureStateListener)
@protocol DSCaptureStateListener <NSObject>

@required

/**
 * The method for monitoring the capture state.
 *
 * @param state One of the DSCaptureState value that indicates the capture state.
 */
- (void)onCapturedStateChanged:(DSCaptureState)state;

@end
