/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class DSLineSegment;

/**
 * DSCornerType defines the enumerations that indicates the corner type.
 */
typedef NS_ENUM(NSInteger, DSCornerType) {
/**
     * The corner is formed by two intersecting line segments.
     */
    DSCornerTypeNormalIntersected,
/**
     * The corner is formed by two T intersecting line segments.
     */
    DSCornerTypeTIntersected,
/**
     * The corner is formed by two cross intersecting line segments.
     */
    DSCornerTypeCrossIntersected,
/**
     * The two line segments are not intersected but they definitly consist a corner.
     */
    DSCornerTypeNotIntersected
} NS_SWIFT_NAME(CornerType);

NS_ASSUME_NONNULL_BEGIN

/**
 * Defines the detected corner. A DSCorner consists of a intersection and the two lines of the corner.
 */
NS_SWIFT_NAME(Corner)
@interface DSCorner : NSObject
/**
 * The type of the corner. The types are availabled as normal-intersected, T-intersected, cross-intersected, not-intersected.
 */
@property (nonatomic, assign) DSCornerType type;
/**
 * The coordinate of the intersection point of the corner.
 */
@property (nonatomic, assign) CGPoint intersection;
/**
 * One of the line of the corner. Defined in DSLineSegment.
 */
@property (nonatomic, strong) DSLineSegment *line1;
/**
 * One of the line of the corner. Defined in DSLineSegment.
 */
@property (nonatomic, strong) DSLineSegment *line2;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCornerType:(DSCornerType)type
                      intersection:(CGPoint)intersection
                             line1:(DSLineSegment *)line1
                             line2:(DSLineSegment *)line2;

@end

NS_ASSUME_NONNULL_END
