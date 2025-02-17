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
 * DSTextureRemovedBinaryImageUnit class represents a unit that contains a texture-removed binary image. It is derived from the DSIntermediateResultUnit class.
 */
NS_SWIFT_NAME(TextureRemovedBinaryImageUnit)
@interface DSTextureRemovedBinaryImageUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * A DSImageData object as the image data of the texture-removed binary image.
 */
- (nullable DSImageData *)getImageData;

- (NSInteger)setImageData:(DSImageData *)imageData;

@end

NS_ASSUME_NONNULL_END
