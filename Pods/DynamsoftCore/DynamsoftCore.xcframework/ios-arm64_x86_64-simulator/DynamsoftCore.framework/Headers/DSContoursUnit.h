/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSIntermediateResultUnit.h>

@class DSContour;
@class DSVector4;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSContoursUnit class represents a unit that contains contours as intermediate results. It is derived from the DSIntermediateResultUnit class
 */
NS_SWIFT_NAME(ContoursUnit)
@interface DSContoursUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * An array of DSContour objects.
 */
- (nullable NSArray<DSContour *> *)getContours;
/**
 * An array of DSVector4 objects that specifies the hierarchies of the contours.
 */
- (nullable NSArray<DSVector4 *> *)getHierarchies;

/**
 * Set the contours with their hierarchies and a transformation matrix to transform the coordinate base to the original image.
 * @param contours An array of DSContour.
 * @param hierarchies An array of Vector4 that defines the hierarchies of the contours.
 * @param matrixToOriginalImage The transformation matrix that transfer the coordinate base to the original image.
 */
-(NSInteger)setContours:(NSArray<DSContour *> *)contours
            hierarchies:(NSArray<DSVector4 *> *)hierarchies
  matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

@end

NS_ASSUME_NONNULL_END
