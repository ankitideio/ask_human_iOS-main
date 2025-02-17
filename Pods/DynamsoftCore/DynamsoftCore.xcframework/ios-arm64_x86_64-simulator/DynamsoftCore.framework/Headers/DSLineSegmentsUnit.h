/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSIntermediateResultUnit.h>

@class DSLineSegment;

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSLineSegmentsUnit class represents a collection of line segments in 2D space. It is a derived class of DSIntermediateResultUnit
 */
NS_SWIFT_NAME(LineSegmentsUnit)
@interface DSLineSegmentsUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * An array of DSLineSegment.
 */
- (nullable NSArray<DSLineSegment *> *)getLineSegments;

- (NSInteger)getCount;

- (nullable DSLineSegment *)getLineSegment:(NSInteger)index;

- (void)removeAllLineSegments;

- (NSInteger)removeLineSegment:(NSInteger)index;

- (NSInteger)addLineSegment:(DSLineSegment *)line
      matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

- (NSInteger)setLineSegment:(NSInteger)index
                       line:(DSLineSegment *)line
      matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

@end

NS_ASSUME_NONNULL_END
