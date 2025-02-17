/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <DynamsoftCore/DynamsoftCore.h>

@class DSCharacterResult;

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSRecognizedTextLineElement class represents a line of recognized text in an image. It inherits from the DSRegionObjectElement class.
 */
NS_SWIFT_NAME(RecognizedTextLineElement)
@interface DSRecognizedTextLineElement : DSRegionObjectElement

/**
* Gets the recognized raw text, excluding any concatenation separators.
*
* @return Returns the recognized raw text.
*/
- (NSString*)getRawText;

- (void)setText:(NSString *)text;

/**
 * The recognized text.
 */
- (NSString *)getText;

/**
 * The confidence level of the recognized text.
 */
- (NSInteger)getConfidence;

/**
 * The row number of the text line within the image.
 */
- (NSInteger)getRowNumber;

/**
 * An array of DSCharacterResult.
 */
- (nullable NSArray<DSCharacterResult *>*)getCharacterResults;

/**
 * Get the name of the TextLineSpecification object that generated this TextLineResultItem.
 * @return The name of the TextLineSpecification object that generated this TextLineResultItem.
 */
- (NSString *)getSpecificationName;

+ (instancetype)new;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
