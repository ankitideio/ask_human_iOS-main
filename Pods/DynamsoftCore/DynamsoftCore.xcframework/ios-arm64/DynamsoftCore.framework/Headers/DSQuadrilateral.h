/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSQuadrilateral class represents a quadrilateral shape in 2D space. It contains an array of four CGPoint, which represent the vertices of the quadrilateral.
 */
NS_SWIFT_NAME(Quadrilateral)
@interface DSQuadrilateral : NSObject
/**
 * Four vertexes in a clockwise direction of a quadrilateral. Index 0 represents the left-most vertex.
 */
@property (nonatomic, readonly, copy) NSArray *points;
/**
 * The bounding rectangle of the quadrilateral.
 */
@property (nonatomic, readonly) CGRect boundingRect;
/**
 * The centre point of the quadrilateral.
 */
@property (nonatomic, readonly) CGPoint centrePoint;
/**
 * The area of the quadrilateral.
 */
@property (nonatomic, readonly) NSUInteger area;

/**
 * Check whether the input point is contained by the quadrilateral.
 * @param [in] point Input a point.
 * @return A BOOL value that indicates whether the point is contained bt the quadrilateral.
 */
- (BOOL)contains:(CGPoint)point;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPointArray:(NSArray *)points;

@end

NS_ASSUME_NONNULL_END
