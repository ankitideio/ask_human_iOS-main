/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSIntermediateResultUnit.h>

@class DSLineSegment;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ShortLinesUnit)
@interface DSShortLinesUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (nullable NSArray<DSLineSegment *> *)getShortLines;

- (NSInteger)getCount;

- (nullable DSLineSegment *)getShortLine:(NSInteger)index;

- (void)removeAllShortLines;

- (NSInteger)removeShortLine:(NSInteger)index;

- (NSInteger)addShortLine:(DSLineSegment *)line
    matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

- (NSInteger)setShortLine:(NSInteger)index
                     line:(DSLineSegment *)line
    matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

@end

NS_ASSUME_NONNULL_END
