/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSIntermediateResultUnit.h>

@class DSPredetectedRegionElement;

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSPredetectedRegionsUnit class represents a unit that contains a collection of pre-detected regions. It inherits from the DSIntermediateResultUnit class and stores the result of image color pre-detection.
 */
NS_SWIFT_NAME(PredetectedRegionsUnit)
@interface DSPredetectedRegionsUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * An array of DSPredetectedRegionsUnit objects.
 */
- (nullable NSArray<DSPredetectedRegionElement *> *)getPredetectedRegions;

- (NSInteger)getCount;

/**
 * Get the predetected region by specifying the index.
 * @param index The index of the region.
 * @return The specified predetected region.
 */
- (nullable DSPredetectedRegionElement *)getPredetectedRegion:(NSInteger)index;

/**
 * Remove all the predetected regions.
 */
- (void)removeAllPredectedRegions;

/**
 * Remove the predetected region by specifying the index.
 * @param index The index of the region to remove.
 * @return Return the error code if an error occurs.
 */
- (NSInteger)removePredetectedRegion:(NSInteger)index;

/**
 * Add a user define region as the predetected region. A transformation matrix is included to transfer the coordinate base to the original image.
 * @param element A DSPredetectedRegionElement object.
 * @param matrixToOriginalImage The transformation matrix that transfer the coordinate base to the original image.
 * @return Return the error code if an error occurs.
 */
- (NSInteger)addPredetectedRegion:(DSPredetectedRegionElement*)element
            matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

/**
 * Add a user define region as the predetected region. A transformation matrix is included to transfer the coordinate base to the original image.
 * @param element A DSPredetectedRegionElement object.
 * @param matrixToOriginalImage The transformation matrix that transfer the coordinate base to the original image.
 * @return Return the error code if an error occurs.
 */
- (NSInteger)setPredetectedRegion:(NSInteger)index
                          element:(DSPredetectedRegionElement*)element
            matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

@end

NS_ASSUME_NONNULL_END
