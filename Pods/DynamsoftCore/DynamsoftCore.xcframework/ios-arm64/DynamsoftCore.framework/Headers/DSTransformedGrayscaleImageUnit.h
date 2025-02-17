/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSIntermediateResultUnit.h>

@class DSImageData;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSTransformedGrayscaleImageUnit class represents a unit that contains a transformed grayscale image. It is derived from the DSIntermediateResultUnit class.
 */
NS_SWIFT_NAME(TransformedGrayscaleImageUnit)
@interface DSTransformedGrayscaleImageUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * A DSImageData object as the image data of the transformed grayscale image.
 */
- (nullable DSImageData *)getImageData;

- (NSInteger)setImageData:(DSImageData *)imageData;

@end

NS_ASSUME_NONNULL_END
