/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class DSImageData;
@class DSDrawingItem;
@class DSDrawingLayer;
@class DSTipConfig;
@protocol DSDrawingItemClickListener;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSImageEditorView is the class that previews an original image. UI controlling APIs of the class enable users to add interactable UI elements on the view.
 */
NS_SWIFT_NAME(ImageEditorView)
@interface DSImageEditorView : UIView
/**
 * The property that stores the original image as a UIImage.
 */
@property (nonatomic, strong) UIImage *image;
/**
 * The property that stores the original image as a DSImageData.
 */
@property (nonatomic, strong) DSImageData *imageData;

/**
 * Get the selected DrawingItem.
 *
 * @return The selected DrawingItem.
 */
- (nullable DSDrawingItem *)getSelectedDrawingItem;

/**
 * Get the specified DrawingLayer.
 *
 * @param [in] layerId The ID of the layer that you want to get.
 *
 * @return The object of the targeting layer.
 */
- (nullable DSDrawingLayer *)getDrawingLayer:(NSUInteger)layerId;

/**
 * Create a new DrawingLayer.
 *
 * @return The object of the layer you created.
 */
- (DSDrawingLayer *)createDrawingLayer;

/**
 * Get all the drawing layers on the view.
 *
 * @return All the drawing layers. The return value includes both system drawing layers and user defined drawing layers.
 */
- (NSArray<DSDrawingLayer *> *)getAllDrawingLayers;

/**
 * Delete the specified drawing layer.
 *
 * @param [in] layerId The ID of the layer that you want to delete.
 */
- (void)deleteUserDefinedDrawingLayer:(NSUInteger)layerId;

/**
 * Clear all the user-defined drawing layers.
 */
- (void)clearUserDefinedDrawingLayers;
/**
 * Set/get the tip configurations.
 */
@property (nonatomic, strong) DSTipConfig *tipConfig;
/**
 * Set/get the visibility of tip.
 */
@property (nonatomic, assign) BOOL tipVisible;

/**
 * Update the tip message. The new tip message will be immediately displayed on the view. Generally, tip messages are uploaded internally.
 *
 * @param [in] message The new message that you want to display.
 */
- (void)updateTipMessage:(NSString *)message;

- (void)setDrawingItemClickListener:(nullable id<DSDrawingItemClickListener>)listener;

@end

NS_ASSUME_NONNULL_END
