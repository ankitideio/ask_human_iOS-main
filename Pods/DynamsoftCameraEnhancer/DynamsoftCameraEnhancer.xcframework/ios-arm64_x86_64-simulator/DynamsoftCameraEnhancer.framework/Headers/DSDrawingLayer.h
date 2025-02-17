/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCameraEnhancer/DSDrawingItem.h>

typedef NS_ENUM(NSUInteger, DSDrawingLayerId) {
/**
     * The preset DrawingLayer of Dynamsoft Document Normalizer.
     */
    DSDrawingLayerIdDDN = 1,
/**
     * The preset DrawingLayer of Dynamsoft Barcode Reader.
     */
    DSDrawingLayerIdDBR = 2,
/**
     * The preset DrawingLayer of Dynamsoft Label Recognizer.
     */
    DSDrawingLayerIdDLR = 3,
/**
     * The IDs of user defined Drawinglayers start from 100.
     */
    DSDrawingLayerIdUserDefinedBase = 100,
} NS_SWIFT_NAME(DrawingLayerId);

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSDrawingLayer class defines DrawingItem management methods and properties. You can add or remove DrawingItems and also control their styles via an instance of DrawingLayer.
 */
NS_SWIFT_NAME(DrawingLayer)
@interface DSDrawingLayer : NSObject
/**
 * Get the layer ID of the layer.
 */
@property (nonatomic, assign, readonly) NSUInteger layerId;
/**
 * Set/get the visibility of the layer.
 */
@property (nonatomic, assign) BOOL visible;
/**
 * Set/Get the DrawingItems to be displayed on the layer. The previously displayed DrawingItems are removed.
 */
@property (atomic, copy, nullable) NSArray<DSDrawingItem *> *drawingItems;

/**
 * Add a group of DrawingItem to the layer.
 *
 * @param items A array of DrawingItems
 */
- (void)addDrawingItems:(NSArray<DSDrawingItem *> *)items;

/**
 * Set the default style of the layer. A DrawingItem on the layer will use the default style if it doesn't hold a style attribute.
 *
 * @param styleId An ID of DrawingStyle.
 */
- (void)setDefaultStyle:(NSUInteger)styleId;

/**
 * Set the default style of the layer. A DrawingItem on the layer will use the default style if it doesn't hold a style attribute.
 *
 * @param styleId An ID of DrawingStyle.
 * @param state Specify a group of DrawingItem state. It filters which kinds of DrawingItems will use this default style.
 * @param type Specify a group of DrawingItem media type. It filters which kinds of DrawingItems will use this default style.
 */
- (void)setDefaultStyle:(NSUInteger)styleId forState:(NSUInteger)state forType:(NSUInteger)type;

/**
 * Remove all DrawingItems from the layer.
 */
- (void)clearDrawingItems;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
