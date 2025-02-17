/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSImageData;

NS_ASSUME_NONNULL_BEGIN

/**
 * The protocol that defines methos for monitoring the video frame output.
 */
NS_SWIFT_NAME(VideoFrameListener)
@protocol DSVideoFrameListener <NSObject>
/**
 * The method for monitoring the video frame output.
 *
 * @param frame A DSImageData object as a video frame.
 */
- (void)onFrameOutPut:(DSImageData *)frame;

@end

NS_ASSUME_NONNULL_END
