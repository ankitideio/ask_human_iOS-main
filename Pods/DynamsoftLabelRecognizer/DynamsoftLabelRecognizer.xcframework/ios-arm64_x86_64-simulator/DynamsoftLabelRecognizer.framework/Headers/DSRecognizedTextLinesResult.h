/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class DSTextLineResultItem;
@class DSImageTag;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSRecognizedTextLinesResult class represents the result of a text recognition process. It provides access to the recognized text lines and other additional information.
 */
NS_SWIFT_NAME(RecognizedTextLinesResult)
@interface DSRecognizedTextLinesResult : NSObject

/**
 * The hash id of the original image. You can use this ID to get the source image via IntermediateResultManager class.
 */
@property (nonatomic, readonly, copy) NSString *originalImageHashId;

/**
 * The tag of the original image.
 */
@property (nonatomic, readonly, strong, nullable) DSImageTag *originalImageTag;

/**
 * An array of DSTextLineResultItems.
 */
@property (nonatomic, readonly, copy, nullable) NSArray<DSTextLineResultItem *> *items;

/**
 * The rotation transformation matrix of the original image relative to the rotated image.
 */
@property (nonatomic, readonly, assign) CGAffineTransform rotationTransformMatrix;

/**
 * Get the error code of this result. A RecognizedTextLinesResult will carry error information when the license module is missing or the process timeout.
 */
@property (nonatomic, readonly, assign) NSInteger errorCode;

/**
 * Get the error message of this result. A RecognizedTextLinesResult will carry error information when the license module is missing or the process timeout.
 */
@property (nonatomic, readonly, copy, nullable) NSString * errorMessage;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
