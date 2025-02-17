/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <DynamsoftCore/DynamsoftCore.h>

@class DSLocalizedTextLineElement;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSLocalizedTextLinesUnit class represents a unit that contains localized text lines. It inherits from the DSIntermediateResultUnit class.
 */
NS_SWIFT_NAME(LocalizedTextLinesUnit)
@interface DSLocalizedTextLinesUnit : DSIntermediateResultUnit

- (NSInteger)getCount;

- (nullable NSArray<DSLocalizedTextLineElement *> *)getLocalizedTextLines;

/**
 * Get the localized text line by specifying the index.
 * @param index The index of the localized text line.
 * @return The specified localized text line.
 */
- (nullable DSLocalizedTextLineElement *)getLocalizedTextLine:(NSInteger)index;

/**
 * Add a user define LocalizedTextLineElement as the localized text line. A transformation matrix is included to transfer the coordinate base to the original image.
 * @param element A DSLocalizedTextLineElement object defines the localized text line to set.
 * @param matrixToOriginalImage The transformation matrix that transfer the coordinate base to the original image.
 * @return Return the error code if an error occurs.
 */
- (NSInteger)setLocalizedTextLine:(NSInteger)index
                          element:(DSLocalizedTextLineElement *)element
            matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

/**
 * Add a user define LocalizedTextLineElement as the localized text line. A transformation matrix is included to transfer the coordinate base to the original image.
 * @param element A DSLocalizedTextLineElement object defines the localized text line to add.
 * @param matrixToOriginalImage The transformation matrix that transfer the coordinate base to the original image.
 * @return Return the error code if an error occurs.
 */
- (NSInteger)addLocalizedTextLine:(DSLocalizedTextLineElement *)element
            matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

/**
 * Remove all the localized text lines.
 */
- (void)removeAllLocalizedTextLines;

/**
 * Remove the localized text line by specifying the index.
 * @param index The index of the localized text line to remove.
 * @return Return the error code if an error occurs.
 */
- (NSInteger)removeLocalizedTextLine:(NSInteger)index;


+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
