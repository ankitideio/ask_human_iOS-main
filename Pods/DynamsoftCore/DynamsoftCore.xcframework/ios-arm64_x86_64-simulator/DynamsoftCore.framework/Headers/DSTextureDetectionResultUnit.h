/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSIntermediateResultUnit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSTextureDetectionResultUnit class represents an intermediate result unit for texture detection. It is derived from the DSIntermediateResultUnit class and contains the x-direction spacing and y-direction spacing of the texture stripes.
 */
NS_SWIFT_NAME(TextureDetectionResultUnit)
@interface DSTextureDetectionResultUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * X-direction spacing of the texture stripes.
 */
- (NSInteger)getXSpacing;
/**
 * Y-direction spacing of the texture stripes.
 */
- (NSInteger)getYSpacing;

- (void)setXSpacing:(NSInteger)xSpacing;

- (void)setYSpacing:(NSInteger)ySpacing;

@end

NS_ASSUME_NONNULL_END
