/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Utility module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <DynamsoftCore/DynamsoftCore.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ProactiveImageSourceAdapter)
@interface DSProactiveImageSourceAdapter : DSImageSourceAdapter

/**
 * Sets the time interval for the ImageSource to wait before attempting to fetch another image to put in the buffer.
 *
 * @param [in] milliseconds The time interval in milliseconds.
 */
- (void)setImageFetchInterval:(NSInteger)milliseconds;

/**
 * Gets the time interval for the ImageSource to wait before attempting to fetch another image to put in the buffer.
 *
 * @return Returns the time interval in milliseconds.
 */
- (NSInteger)getImageFetchInterval;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
