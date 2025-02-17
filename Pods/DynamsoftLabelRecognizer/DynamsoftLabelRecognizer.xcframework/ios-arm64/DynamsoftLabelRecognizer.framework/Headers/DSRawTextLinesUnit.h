/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <DynamsoftCore/DynamsoftCore.h>

@class DSRawTextLine;
NS_ASSUME_NONNULL_BEGIN

/**
* DSRawTextLinesUnit extends the DSIntermediateResultUnit class and represents a unit which holds the raw text lines.
*
*/
NS_SWIFT_NAME(RawTextLinesUnit)
@interface DSRawTextLinesUnit : DSIntermediateResultUnit

/**
* Gets the number of raw text lines in the unit.
*
* @return Returns the number of raw text lines in the unit.
*
*/
- (NSInteger)getCount;

/**
* Gets all raw text lines of the unit.
*
* @return Returns all the raw text lines of the unitin an array.
*
*/
- (nullable NSArray<DSRawTextLine *> *)getRawTextLines;

/**
* Gets a raw text line at the specified index.
*
* @param [in] index The index of the raw text line.
*
* @return Returns a pointer to the RawTextLine object at the specified index.
*
*/
- (nullable DSRawTextLine*)getRawTextLine:(NSInteger)index;

/**
* Sets the raw text line at the specified index.
*
* @param index The index of the raw text line to set.
* @param textline The raw text line to set.
* @param matrixToOriginalImage The matrix to original image.
* @return Returns 0 if successful, otherwise returns a negative value.
*/
- (NSInteger)setRawTextLine:(NSInteger)index
                   element:(DSRawTextLine *)textline
     matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

/**
* Adds a raw text line.
*
* @param textline The raw text line to add.
* @param matrixToOriginalImage The matrix to original image.
* @return Returns 0 if successful, otherwise returns a negative value.
*/
- (NSInteger)addRawTextLine:(DSRawTextLine *)textline
     matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

/**
* Removes all raw text lines.
*
*/
- (void)removeAllRawTextLines;

/**
* Removes the raw text line at the specified index.
*
* @param index The index of the raw text line to remove.
* @return Returns 0 if successful, otherwise returns a negative value.
*/
- (NSInteger)removeRawTextLine:(NSInteger)index;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
