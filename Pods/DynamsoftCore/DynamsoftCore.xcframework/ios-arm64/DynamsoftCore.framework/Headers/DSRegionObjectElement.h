/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSQuadrilateral;

/**
 * DSRegionObjectElementType defines the enumerations that indicates the types of the region object.
 */
typedef NS_ENUM(NSInteger, DSRegionObjectElementType) {
/**
     * The type of the region object is a "Predetected region".
     */
    DSRegionObjectElementTypePredetectedRegion,
/**
     * The type of the region object is a "localized barcode".
     */
    DSRegionObjectElementTypeLocalizedBarcode,
/**
     * The type of the region object is a "decoded barcode".
     */
    DSRegionObjectElementTypeDecodedBarcode,
/**
     * The type of the region object is a "localized text line".
     */
    DSRegionObjectElementTypeLocalizedTextLine,
/**
     * The type of the region object is a "recognized text line".
     */
    DSRegionObjectElementTypeRecognizedTextLine,
/**
     * The type of the region object is a "detected quad".
     */
    DSRegionObjectElementTypeDetectedQuad,
/**
     * The type of the region object is a "normalized image".
     */
    DSRegionObjectElementTypeNormalizedImage,
} NS_SWIFT_NAME(RegionObjectElementType);

NS_ASSUME_NONNULL_BEGIN

/**
 * DSRegionObjectElement class represents an element of a region object in 2D space. It is an abstract class that provides the interface for region object elements.
 */
NS_SWIFT_NAME(RegionObjectElement)
@interface DSRegionObjectElement : NSObject
/**
 * The location info of the element that defined in DSQuadrilateral.
 */
- (DSQuadrilateral *)getLocation;

- (NSInteger)setLocation:(DSQuadrilateral *)location;
/**
 * The type of the element.
 */
- (DSRegionObjectElementType)getType;
/**
 * The referenced element that supports the capturing of this element.
 */
- (nullable DSRegionObjectElement *)getReferencedElement NS_SWIFT_NAME(getReferencedElement());

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
