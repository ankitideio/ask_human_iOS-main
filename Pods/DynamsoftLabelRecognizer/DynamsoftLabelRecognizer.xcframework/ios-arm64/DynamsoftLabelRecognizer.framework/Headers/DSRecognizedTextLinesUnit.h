/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <DynamsoftCore/DynamsoftCore.h>

@class DSRecognizedTextLineElement;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSRecognizedTextLinesUnit class represents an intermediate result unit containing recognized text lines. It inherits from the DSIntermediateResultUnit class.
 */
NS_SWIFT_NAME(RecognizedTextLinesUnit)
@interface DSRecognizedTextLinesUnit : DSIntermediateResultUnit

- (NSInteger)getCount;

- (nullable NSArray<DSRecognizedTextLineElement *> *)getRecognizedTextLines;

/**
 * Get the recognized text line by specifying the index.
 * @param index The index of the recognized text line.
 * @return The specified recognized text line.
 */
- (nullable DSRecognizedTextLineElement *)getRecognizedTextLine:(NSInteger)index;

/**
* Sets the recognized text line at the specified index.
*
* @param index The index of the recognized text line to set.
* @param element The recognized text line to set.
* @param matrixToOriginalImage The matrix to original image.
* @return Returns 0 if successful, otherwise returns a negative value.
*/
- (NSInteger)setRecognizedTextLine:(NSInteger)index
                           element:(DSRecognizedTextLineElement*)element
             matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

/**
* Adds a recognized text line.
*
* @param element The recognized text line to add.
* @param matrixToOriginalImage The matrix to original image.
* @return Returns 0 if successful, otherwise returns a negative value.
*/
- (NSInteger)addRecognizedTextLine:(DSRecognizedTextLineElement*)element
             matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

/**
 * Remove all the recognized text lines.
 */
- (void)removeAllRecognizedTextLines;

/**
* Removes the recognized text line at the specified index.
*
* @param index The index of the text line to remove.
* @return Returns 0 if successful, otherwise returns a negative value.
*/
- (NSInteger)removeRecognizedTextLine:(NSInteger)index;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
