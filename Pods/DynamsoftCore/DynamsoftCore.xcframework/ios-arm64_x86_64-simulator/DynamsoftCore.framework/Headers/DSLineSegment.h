/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSLineSegment class represents a line segment in 2D space. It contains the start point and end point of the line segment.
 */
NS_SWIFT_NAME(LineSegment)
@interface DSLineSegment : NSObject
/**
 * The start point of the line segment.
 */
@property (nonatomic, assign) CGPoint startPoint;
/**
 * The end point of the line segment.
 */
@property (nonatomic, assign) CGPoint endPoint;

- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
