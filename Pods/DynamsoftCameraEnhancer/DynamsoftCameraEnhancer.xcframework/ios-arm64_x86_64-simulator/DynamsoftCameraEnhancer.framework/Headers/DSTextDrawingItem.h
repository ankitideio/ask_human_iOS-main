/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <DynamsoftCameraEnhancer/DSDrawingItem.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSTextDrawingItem is a subclass of DSDrawingItem. Add DSTextDrawingItem to draw texts on the view.
 */
NS_SWIFT_NAME(TextDrawingItem)
@interface DSTextDrawingItem : DSDrawingItem
/**
 * Get the text content of the DSTextDrawingItem.
 */
@property (nonatomic, copy, readonly) NSString *text;
/**
 * Get the top-left point of the DSTextDrawingItem.
 */
@property (nonatomic, assign, readonly) CGPoint topLeftPoint;
/**
 * Get the width of the DSTextDrawingItem.
 */
@property (nonatomic, assign, readonly) NSUInteger width;
/**
 * Get the height of the DSTextDrawingItem.
 */
@property (nonatomic, assign, readonly) NSUInteger height;

- (instancetype)initWithDrawingStyleId:(NSUInteger)styleId
                                 state:(DSDrawingItemState)state
                        coordinateBase:(DSCoordinateBase)coordinateBase
                                  text:(NSString *)text
                          topLeftPoint:(CGPoint)point
                                 width:(NSUInteger)width
                                height:(NSUInteger)height NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithText:(NSString *)text
                topLeftPoint:(CGPoint)point
                       width:(NSUInteger)width
                      height:(NSUInteger)height;

@end

NS_ASSUME_NONNULL_END
