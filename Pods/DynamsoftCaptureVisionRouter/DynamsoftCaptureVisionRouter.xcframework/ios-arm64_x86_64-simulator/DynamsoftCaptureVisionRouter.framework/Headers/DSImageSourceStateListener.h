/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * DSImageSourceState defines the enumerations that indicates the state of ImageSourceAdapter.
 */
typedef NS_ENUM(NSInteger, DSImageSourceState)
{
    /**
     * The image buffer is empty.
     */
    DSImageSourceStateBufferEmpty = 0,
    /**
     * The image source is exhausted.
     */
    DSImageSourceStateExhausted = 1
}NS_SWIFT_NAME(ImageSourceState);

/**
 * The protocol that defines methods for monitoring the state of the ImageSourceAdapter.
 */
NS_SWIFT_NAME(ImageSourceStateListener)
@protocol DSImageSourceStateListener <NSObject>

@required

/**
 * The methods for monitoring the state of the ImageSourceAdapter.
 *
 * @param state One of the DSImageSourceState that indicates the state of the ImageSourceAdapter.
 */
- (void)onImageSourceStateReceived:(DSImageSourceState)state;

@end
