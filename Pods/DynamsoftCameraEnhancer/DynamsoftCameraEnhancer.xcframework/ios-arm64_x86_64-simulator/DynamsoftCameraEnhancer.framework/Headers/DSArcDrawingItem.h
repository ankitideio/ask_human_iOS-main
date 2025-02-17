/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <DynamsoftCameraEnhancer/DSDrawingItem.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ArcDrawingItem)
@interface DSArcDrawingItem : DSDrawingItem

@property (nonatomic, assign, readonly) CGPoint centre;

@property (nonatomic, assign, readonly) CGFloat radius;

- (instancetype)initWithDrawingStyleId:(NSUInteger)styleId
                                 state:(DSDrawingItemState)state
                        coordinateBase:(DSCoordinateBase)coordinateBase
                                centre:(CGPoint)centre
                                radius:(CGFloat)radius NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCentre:(CGPoint)centre radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
