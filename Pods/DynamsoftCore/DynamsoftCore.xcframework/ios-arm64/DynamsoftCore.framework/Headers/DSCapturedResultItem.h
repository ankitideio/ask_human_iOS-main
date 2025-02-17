/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, DSCapturedResultItemType) {
/**
     * The captured result is a raw image. You can convert it into a DSOriginalImageResultItem.
     */
    DSCapturedResultItemTypeOriginalImage = 1 << 0,
/**
     * The captured result is a decoded barcode. You can convert it into a DSBarcodeResultItem.
     */
    DSCapturedResultItemTypeBarcode = 1 << 1,
/**
     * The captured result is a recognized text line. You can convert it into a DSTextLineResultItem.
     */
    DSCapturedResultItemTypeTextLine = 1 << 2,
/**
     * The captured result is a detected quadrilateral. You can convert it into a DSDetectedQuadResultItem.
     */
    DSCapturedResultItemTypeDetectedQuad = 1 << 3,
/**
     * The captured result is a normalized image. You can convert it into a DSNormalizedImageResultItem.
     */
    DSCapturedResultItemTypeNormalizedImage = 1 << 4,
    /**
     * The captured result is a parsed result. You can convert it into a DSParsedResultItem.
     */
    DSCapturedResultItemTypeParsedResult = 1 << 5
} NS_SWIFT_NAME(CapturedResultItemType);

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCapturedResultItem class represents an item in a captured result. It is an abstract base class with multiple subclasses, each representing a different type of captured item such as barcode, text line, detected quad, normalized image, raw image, parsed item, etc.
 */
NS_SWIFT_NAME(CapturedResultItem)
@interface DSCapturedResultItem : NSObject
/**
 * The type of the captured result item.
 */
@property (nonatomic, readonly) DSCapturedResultItemType type;
/**
 * The referenced captured result item. The reference dependencies is defined in the capture vision settings.
 */
@property (nonatomic, readonly, nullable) DSCapturedResultItem *referenceItem;
/**
 * The targetROIDef name that produce this CapturedResultItem.
 */
@property (nonatomic, readonly) NSString *targetROIDefName;
/**
 * The task name that produce this CapturedResultItem.
 */
@property (nonatomic, readonly) NSString *taskName;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
