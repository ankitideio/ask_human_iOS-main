/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Code Parser module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSParsedResultItem;
@class DSImageTag;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSParsedResult class represents the result of a parsed content.
 */
NS_SWIFT_NAME(ParsedResult)
@interface DSParsedResult : NSObject

/**
 * The hash id of the original image. You can use this ID to get the source image via IntermediateResultManager class.
 */
@property (nonatomic, readonly, copy) NSString *originalImageHashId;

/**
 * The tag of the original image.
 */
@property (nonatomic, readonly, strong, nullable) DSImageTag *originalImageTag;

/**
 * An array of DSParsedResultItems, which are the basic unit of the captured results.
 */
@property (nonatomic, readonly, copy, nullable) NSArray<DSParsedResultItem *> *items;

/**
 * Get the error code of this result. A ParsedResult will carry error information when the license module is missing or the process timeout.
 */
@property (nonatomic, readonly, assign) NSInteger errorCode;

/**
 * Get the error message of this result. A ParsedResult will carry error information when the license module is missing or the process timeout.
 */
@property (nonatomic, readonly, copy, nullable) NSString * errorMessage;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
