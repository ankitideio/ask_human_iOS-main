/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The protocol that defines the methods for monitoring the photo output.
 */
NS_SWIFT_NAME(PhotoListener)
@protocol DSPhotoListener <NSObject>

/**
 * The method for monitoring the photo output.
 *
 * @param jpegBytes The captured photo as JPEG bytes.
 */
- (void)onPhotoOutPut:(NSData *)jpegBytes;

@end

NS_ASSUME_NONNULL_END
