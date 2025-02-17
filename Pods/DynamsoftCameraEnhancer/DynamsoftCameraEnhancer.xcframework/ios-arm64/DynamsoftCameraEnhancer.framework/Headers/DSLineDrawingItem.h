/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <DynamsoftCameraEnhancer/DSDrawingItem.h>

@class DSLineSegment;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSLineDrawingItem is a subclass of DSDrawingItem. Add DSLineDrawingItem to draw line segments on the view.
 */
NS_SWIFT_NAME(LineDrawingItem)
@interface DSLineDrawingItem : DSDrawingItem
/**
 * Get the line information of the DSLineDrawingItem.
 */
@property (nonatomic, strong, readonly) DSLineSegment *line;

- (instancetype)initWithDrawingStyleId:(NSUInteger)styleId
                                 state:(DSDrawingItemState)state
                        coordinateBase:(DSCoordinateBase)coordinateBase
                           lineSegment:(DSLineSegment *)line NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithLineSegment:(DSLineSegment *)line;

@end

NS_ASSUME_NONNULL_END
