/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class DSDrawingLayer;
@class DSRect;
@class DSTipConfig;
@protocol DSDrawingItemClickListener;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCameraView is the class that displays the camera preview. UI controlling APIs of the class enable users to add interactable UI elements on the view.
 */
NS_SWIFT_NAME(CameraView)
@interface DSCameraView : UIView
/**
 * Set/get the visibility of the torch button.
 */
@property (nonatomic, assign) BOOL torchButtonVisible;
/**
 * Set/get the visibility of the scan region mask.
 */
@property (nonatomic, assign) BOOL scanRegionMaskVisible;
/**
 * Set/get the visibility of the scan laser.
 */
@property (nonatomic, assign) BOOL scanLaserVisible;

/**
 * Get the visible region of the video streaming.
 *
 * @return A DSRect object (measuredInPercentage = 1) that defines the visible region of the video.
 */
- (DSRect *)getVisibleRegionOfVideo;

/**
 * Add a torch button on your view. If you are using enhanced feature - smart torch, the style of this torch button will be applied to the smart torch as well.
 *
 * @param [in] frame The place that you want to locate the torch button.
 * @param [in] onImage The torch button image that you want to display when the torch is on.
 * @param [in] offImage The torch button image that you want to display when the torch is off.
 */
- (void)setTorchButtonWithFrame:(CGRect)frame
                   torchOnImage:(nullable UIImage *)onImage
                  torchOffImage:(nullable UIImage *)offImage NS_SWIFT_NAME(setTorchButton(frame:torchOnImage:torchOffImage:));

/**
 * Set the style of the scan region mask.
 *
 * @param strokeColour The stroke colour of the scan region box.
 * @param strokeWidth The width of the stroke.
 * @param surroundingColour The colour of the mask around the scan region.
 */
- (void)setScanRegionMaskStyle:(UIColor *)strokeColour
                   strokeWidth:(CGFloat)strokeWidth
             surroundingColour:(UIColor *)surroundingColour;

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
 * Get all the drawing layers on the view.
 *
 * @return All the drawing layers. The return value includes both system drawing layers and user defined drawing layers.
 */
- (NSArray<DSDrawingLayer *> *)getAllDrawingLayers;

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
