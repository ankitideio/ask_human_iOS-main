/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <DynamsoftCore/DynamsoftCore.h>

@class DSCharacterResult;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSTextLineResultItem class represents a text line result item recognized by the library. It is derived from DSCapturedResultItem
 */
NS_SWIFT_NAME(TextLineResultItem)
@interface DSTextLineResultItem : DSCapturedResultItem

/**
 * The text content of the text line.
 */
@property (nonatomic, readonly, copy) NSString *text;

/**
* The recognized raw text, excluding any concatenation separators.
*/
@property (nonatomic, readonly, copy) NSString *rawText;

/**
 * The location of the text line in the form of a quadrilateral.
 */
@property (nonatomic, readonly, strong) DSQuadrilateral *location;

/**
 * The confidence of the text line recognition result.
 */
@property (nonatomic, readonly, assign) NSInteger confidence;

/**
 * An array of DSCharacterResult.
 */
@property (nonatomic, readonly, copy, nullable) NSArray<DSCharacterResult *> *charResult;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
