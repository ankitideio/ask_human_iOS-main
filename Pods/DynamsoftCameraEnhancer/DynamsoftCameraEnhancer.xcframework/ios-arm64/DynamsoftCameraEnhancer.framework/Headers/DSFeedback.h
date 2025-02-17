/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSFeedback defines methods to trigger feedbacks from the hardware.
 */
NS_SWIFT_NAME(Feedback)
@interface DSFeedback : NSObject

/**
 * Trigger a vibrate.
 */
+ (void)beep;

/**
 * Trigger a beep.
 */
+ (void)vibrate;

@end

NS_ASSUME_NONNULL_END
