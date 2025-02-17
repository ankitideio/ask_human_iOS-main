/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSRect class represents a rectangle in 2D space. It contains four integer values that specify the top, left, right, and bottom edges of the rectangle.
 */
NS_SWIFT_NAME(Rect)
@interface DSRect : NSObject
/**
 * The distance between the top of the rect and the top border of the image.
 * @par If measuredInPercentage = 1, the value specifies the percentage comparing with the height of the parent.
 * @par If measuredInPercentage = 0, the value specifies a pixel length.
 */
@property (nonatomic, assign) CGFloat top;
/**
 * The distance between the left of the rect and the left border of the image.
 * @par If measuredInPercentage = 1, the value specifies the percentage comparing with the width of the parent.
 * @par If measuredInPercentage = 0, the value specifies a pixel length.
 */
@property (nonatomic, assign) CGFloat left;
/**
 * The distance between the right of the rect and the left border of the image
 * @par If measuredInPercentage = 1, the value specifies the percentage comparing with the width of the parent.
 * @par If measuredInPercentage = 0, the value specifies a pixel length.
 */
@property (nonatomic, assign) CGFloat right;
/**
 * The distance between the bottom of the rect and the top border of the image.
 * @par If measuredInPercentage = 1, the value specifies the percentage comparing with the height of the parent.
 * @par If measuredInPercentage = 0, the value specifies a pixel length.
 */
@property (nonatomic, assign) CGFloat bottom;
/**
 * Sets whether to use percentages to measure the region size.
 */
@property (nonatomic, assign) BOOL measuredInPercentage;

@end

NS_ASSUME_NONNULL_END
