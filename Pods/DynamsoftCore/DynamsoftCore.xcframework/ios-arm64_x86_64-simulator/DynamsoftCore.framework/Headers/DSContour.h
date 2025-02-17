/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSContour class represents a contour in 2D space. It contains an array of CPoint objects, which represent the vertices of the contour
 */
NS_SWIFT_NAME(Contour)
@interface DSContour : NSObject

/** An array includes all vertices of the contour. */
@property (nonatomic, copy, nullable) NSArray *points;

- (instancetype)initWithPointArray:(NSArray *)points;

@end

NS_ASSUME_NONNULL_END
