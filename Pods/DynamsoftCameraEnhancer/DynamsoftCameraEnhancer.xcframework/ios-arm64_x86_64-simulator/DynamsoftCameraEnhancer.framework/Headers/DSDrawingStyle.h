/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSDrawingStyle defines the style attributes of the drawing items.
 */
NS_SWIFT_NAME(DrawingStyle)
@interface DSDrawingStyle : NSObject
/**
 * Get the style ID.
 */
@property (nonatomic, assign, readonly) NSUInteger styleId;
/**
 * Set/get the stroke width (in pixel).
 */
@property (nonatomic, assign) CGFloat strokeWidth;
/**
 * Set/get the stroke colour.
 */
@property (nonatomic, strong) UIColor *strokeColor;
/**
 * Set/get the fill colour.
 */
@property (nonatomic, strong) UIColor *fillColor;
/**
 * Set/get the text colour.
 */
@property (nonatomic, strong) UIColor *textColor;
/**
 * Set/get the font.
 */
@property (nonatomic, strong) UIFont *font;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
