/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <DynamsoftCameraEnhancer/DSDrawingItem.h>

@class DSQuadrilateral;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSQuadDrawingItem is a subclass of DSDrawingItem. Add DSQuadDrawingItem to draw quadrilaterals on the view.
 */
NS_SWIFT_NAME(QuadDrawingItem)
@interface DSQuadDrawingItem : DSDrawingItem
/**
 * Get the quadrilateral information of the DSQuadDrawingItem.
 */
@property (nonatomic, strong, readonly) DSQuadrilateral *quad;

- (instancetype)initWithDrawingStyleId:(NSUInteger)styleId
                                 state:(DSDrawingItemState)state
                        coordinateBase:(DSCoordinateBase)coordinateBase
                         quadrilateral:(DSQuadrilateral *)quad NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithQuadrilateral:(DSQuadrilateral *)quad;

@end

NS_ASSUME_NONNULL_END
