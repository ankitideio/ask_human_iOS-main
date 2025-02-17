/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ImageSourceErrorListener)
@protocol DSImageSourceErrorListener <NSObject>

- (void)onErrorReceived:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
