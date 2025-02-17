/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <DynamsoftCameraEnhancer/DSDrawingItem.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSRectDrawingItem is a subclass of DSDrawingItem. Add DSRectDrawingItem to draw rect on the view.
 */
NS_SWIFT_NAME(RectDrawingItem)
@interface DSRectDrawingItem : DSDrawingItem
/**
 * Get the rect information of the DSRectDrawingItem.
 */
@property (nonatomic, assign, readonly) CGRect rect;

- (instancetype)initWithDrawingStyleId:(NSUInteger)styleId
                                 state:(DSDrawingItemState)state
                        coordinateBase:(DSCoordinateBase)coordinateBase
                                  rect:(CGRect)rect NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
