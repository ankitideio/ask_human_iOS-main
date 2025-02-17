/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSCharacterResult;
@class DSQuadrilateral;

typedef NS_ENUM(NSInteger, DSRawTextLineStatus)
{
    /** Localized but recognition not performed. */
    DSRawTextLineStatusLocalized,
    /** Recognition failed. */
    DSRawTextLineStatusRecognitionFailed,
    /** Successfully recognized. */
    DSRawTextLineStatusRecognitionSucceeded
} NS_SWIFT_NAME(RawTextLineStatus);

NS_ASSUME_NONNULL_BEGIN

/**
 * The `RawTextLine` class represents a text line in an image. It can be in one of the following states:
 * - `TLS_LOCALIZED`: Localized but recognition not performed.
 * - `TLS_RECOGNITION_FAILED`: Recognition failed.
 * - `TLS_RECOGNIZED_SUCCESSFULLY`: Successfully recognized.
 */
NS_SWIFT_NAME(RawTextLine)
@interface DSRawTextLine : NSObject

/**
 * Sets the recognized text.
 *
 * @param text The text to be set.
 */
- (void)setText:(NSString *)text;

/**
 * Gets the recognized text.
 *
 * @return Returns the recognized text.
 *
 */
- (NSString *)getText;

/**
 * Gets the confidence level of the recognized text.
 *
 * @return Returns an integer value representing the confidence level of the recognized text.
 *
 */
- (NSInteger)getConfidence;

/**
 * Set the row number of the text line within the image.
 *
 * @param rowNumber The row number of the text line.
 * @return Returns 0 if success, otherwise an error code.
 */
- (NSInteger)setRowNumber:(NSInteger)rowNumber;

/**
 * Gets the row number of the text line within the image.
 *
 * @return Returns an integer value representing the row number of the text line within the image.
 *
 */
- (NSInteger)getRowNumber;

/**
 * Gets all the character recognition results of the raw text line.
 *
 * @return Returns an array of CharacterResult objects as the character recognition results.
 *
 */
- (nullable NSArray<DSCharacterResult *>*)getCharacterResults;

/**
 * Sets the name of the text line specification that generated this element.
 *
 * @param specificationName The name of the text line specification.
 * @return Returns 0 if success, otherwise an error code.
 */
- (NSInteger)setSpecificationName:(NSString *)specificationName;

/**
 * Gets the name of the text line specification that generated this element.
 *
 * @return The name of the text line specification.
 */
- (NSString *)getSpecificationName;

/**
 * Set the location of the text line.
 *
 * @param location The location of the text line.
 * @return Returns 0 if success, otherwise an error code.
 */
- (NSInteger)setLocation:(DSQuadrilateral *)location;

/**
 * Get the location of the text line.
 *
 * @return Returns a DSQuadrilateral object which represents the location of the text line.
 *
 */
- (DSQuadrilateral *)getLocation;

/**
 * Gets the status of the text line.
 *
 * @return The status of the text line.
 */
- (DSRawTextLineStatus)getStatus;

+ (instancetype)new;
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
