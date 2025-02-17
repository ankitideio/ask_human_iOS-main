/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <DynamsoftCore/DSIntermediateResultUnitType.h>

@class DSImageTag;

typedef NS_ENUM(NSInteger, DSTransformMatrixType) {
/**
     * Transform from local to original image.
     */
    DSTransformMatrixTypeLocalToOriginalImage,
/**
     * Transform from original to local image.
     */
    DSTransformMatrixTypeOriginalToLocalImage,
/**
     * Transform from rotated image to original image.
     */
    DSTransformMatrixTypeRotatedToOriginalImage,
/**
     * Transform from original image to rotated image.
     */
    DSTransformMatrixTypeOriginalToRotatedImage,
} NS_SWIFT_NAME(TransformMatrixType);

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSIntermediateResultUnit class represents an intermediate result unit used in image processing. It is an abstract base class with multiple subclasses, each representing a different type of unit such as pre-detected regions, localized barcodes, decoded barcodes, localized text lines, binary image, gray image, etc.
 */
NS_SWIFT_NAME(IntermediateResultUnit)
@interface DSIntermediateResultUnit : NSObject
/**
 * The hash ID of the unit.
 */
- (NSString *)getHashId;
/**
 * The hash id of the original image. You can use this ID to get the original image via IntermediateResultManager class.
 */
- (NSString *)getOriginalImageHashId;
/**
 * The image tag of the original image.
 */
- (nullable DSImageTag *)getOriginalImageTag;
/**
 * The type of the intermediate result unit.
 */
- (DSIntermediateResultUnitType)getType;
/**
 * Get the specified transformation matrix.
 *
 * @param [in] type One of the Transformation matrix type.
 * @return The targeting transformation matrix.
 */
- (CGAffineTransform)getTransformMatrix:(DSTransformMatrixType)type;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (DSIntermediateResultUnit *)clone;

- (NSInteger)replace:(DSIntermediateResultUnit *)oldUnit;

@end

NS_ASSUME_NONNULL_END
