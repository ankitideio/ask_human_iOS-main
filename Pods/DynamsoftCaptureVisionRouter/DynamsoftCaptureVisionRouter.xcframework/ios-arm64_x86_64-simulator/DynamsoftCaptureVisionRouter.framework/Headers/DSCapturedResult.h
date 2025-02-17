/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class DSImageTag;
@class DSCapturedResultItem;
@class DSDecodedBarcodesResult;
@class DSRecognizedTextLinesResult;
@class DSDetectedQuadsResult;
@class DSNormalizedImagesResult;
@class DSParsedResult;

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSCapturedResult class represents the result of a capture operation on an image. Internally, DSCaptureResult stores an array that contains multiple items, each of which may be a barcode, text line, detected quad, normalized image, raw image, parsed item, etc.
 */
NS_SWIFT_NAME(CapturedResult)
@interface DSCapturedResult : NSObject
/**
 * The hash id of the original image. You can use this ID to get the original image via IntermediateResultManager class.
 */
@property (nonatomic, readonly, copy) NSString *originalImageHashId;
/**
 * The tag of the original image that records the information of the original image
 */
@property (nonatomic, readonly, strong, nullable) DSImageTag *originalImageTag;
/**
 * An array of DSCapturedResultItems, which are the basic unit of the captured results.
 * A DSCapturedResultItem can be a raw image, a decoded barcode, a recognized text, a detected quad, a normalized image or a parsed result.
 * View DSCapturedResultItemType for all available types.
 */
@property (nonatomic, readonly, copy, nullable) NSArray<DSCapturedResultItem *> *items;
/**
 * The rotation transformation matrix of the original image relative to the rotated image.
 */
@property (nonatomic, readonly, assign) CGAffineTransform rotationTransformMatrix;

@property (nonatomic, readonly, assign) NSInteger errorCode;

@property (nonatomic, readonly, copy, nullable) NSString *errorMessage;

/**
 * A DSDecodeBarcodesResult object that contains all the DSBarcodeResultItems in the DSCapturedResult.
 */
@property (nonatomic, readonly, strong, nullable) DSDecodedBarcodesResult * decodedBarcodesResult;

/**
 * A DSRecognizedTextLinesResult object that contains all the DSTextLinesResultItems in the DSCapturedResult.
 */
@property (nonatomic, readonly, strong, nullable) DSRecognizedTextLinesResult * recognizedTextLinesResult;

/**
 * A DSDetectedQuadsResult object that contains all the DSDetectedQuadResultItem in the DSCapturedResult.
 */
@property (nonatomic, readonly, strong, nullable) DSDetectedQuadsResult * detectedQuadsResult;

/**
 * A DSNormalizedImagesResult object that contains all the DSNormalizedImageResultItem in the DSCapturedResult.
 */
@property (nonatomic, readonly, strong, nullable) DSNormalizedImagesResult * normalizedImagesResult;

/**
 * A DSParsedResult object that contains all the DSParsedResultItem in the DSCapturedResult.
 */
@property (nonatomic, readonly, strong, nullable) DSParsedResult * parsedResult;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
