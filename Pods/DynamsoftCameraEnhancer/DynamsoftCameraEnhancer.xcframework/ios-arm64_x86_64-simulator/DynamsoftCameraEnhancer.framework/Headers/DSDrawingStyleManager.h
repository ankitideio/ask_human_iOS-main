/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCameraEnhancer/DSDrawingStyle.h>

typedef NS_ENUM(NSUInteger, DSDrawingStyleId) {
/**
     * The style ID of the blue-stroke style.
     */
    DSDrawingStyleIdBlueStroke = 1,
/**
     * The style ID of the green-stroke style.
     */
    DSDrawingStyleIdGreenStroke = 2,
/**
     * The style ID of the orange-stroke style.
     */
    DSDrawingStyleIdOrangeStroke = 3,
/**
     * The style ID of the yellow-stroke style.
     */
    DSDrawingStyleIdYellowStroke = 4,
/**
     * The style ID of the blue-stroke-fill style.
     */
    DSDrawingStyleIdBlueStrokeFill = 5,
/**
     * The style ID of the green-stroke-fill style.
     */
    DSDrawingStyleIdGreenStrokeFill = 6,
/**
     * The style ID of the orange-stroke-fill style.
     */
    DSDrawingStyleIdOrangeStrokeFill = 7,
    /**
         * The style ID of the yellow-stroke-fill style.
         */
    DSDrawingStyleIdYellowStrokeFill = 8,
} NS_SWIFT_NAME(DrawingStyleId);

NS_ASSUME_NONNULL_BEGIN

/**
 * DrawingStyleManager is the manager of DrawingStyles.
 */
NS_SWIFT_NAME(DrawingStyleManager)
@interface DSDrawingStyleManager : NSObject

/**
 * Get the specified DrawingStyle.
 *
 * @param styleId Specify a style ID.
 * @return The DrawingStyle with the specified ID.
 */
+ (nullable DSDrawingStyle *)getDrawingStyle:(NSUInteger)styleId;

/**
 * Create an instance of the DrawingStyle and get the style ID.
 *
 * @param strokeColor Set the stroke colour.
 * @param strokeWidth Set the stroke width.
 * @param fillColor Set the fill colour.
 * @param textColor Set the text colour.
 */
+ (NSUInteger)createDrawingStyle:(UIColor *)strokeColor strokeWidth:(CGFloat)strokeWidth fillColor:(UIColor *)fillColor textColor:(UIColor *)textColor font:(UIFont *)font;

/**
 * Get all available DrawingStyles.
 *
 * @return An array that contains all available DrawingStyles
 */
+ (nullable NSArray<DSDrawingStyle *> *)getAllDrawingStyles;

@end

NS_ASSUME_NONNULL_END
