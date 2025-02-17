/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#ifndef DSCoreModes_h
#define DSCoreModes_h

/**
 * DSGrayscaleEnhancementMode defines the enumerations that indicates the grayscale enhancement mode.
 */
typedef NS_ENUM(NSInteger, DSGrayscaleEnhancementMode) {
/**
    * Skips grayscale enhancement.
    */
    DSGrayscaleEnhancementModeSkip = 0,
/**
    * Not supported yet.
    */
    DSGrayscaleEnhancementModeAuto = 1 << 0,
/**
    * Take the unpreprocessed image as the preprocessed result for further reference.
    */
    DSGrayscaleEnhancementModeGeneral = 1 << 1,
/**
    * Preprocesses the image using the gray equalization algorithm. Check @ref IPM for available argument settings.
    */
    DSGrayscaleEnhancementModeGrayEqualize = 1 << 2,
/**
    * Preprocesses the image using the gray smoothing algorithm. Check @ref IPM for available argument settings.
    */
    DSGrayscaleEnhancementModeGraySmooth = 1 << 3,
/**
    * Preprocesses the image using the sharpening and smoothing algorithm. Check @ref IPM for available argument settings.
    */
    DSGrayscaleEnhancementModeSharpenSmooth = 1 << 4,
    
    DSGrayscaleEnhancementModeRev = NSIntegerMin
} NS_SWIFT_NAME(GrayscaleEnhancementMode);

/**
 * DSGrayscaleTransformationMode defines the enumerations that indicates the grayscale transformation mode.
 */
typedef NS_ENUM(NSInteger, DSGrayscaleTransformationMode) {
/**
    * Skips grayscale transformation.
    */
    DSGrayscaleTransformationModeSkip = 0,
/**
    * Transforms to the inverted grayscale for further reference. This value is recommended for light on dark images.
    */
    DSGrayscaleTransformationModeInverted = 1 << 0,
/**
    * Keeps the original grayscale for further reference. This value is recommended for dark on light images.
    */
    DSGrayscaleTransformationModeOriginal = 1 << 1,
/**
    * Lets the library choose an algorithm automatically for grayscale transformation.
    */
    DSGrayscaleTransformationModeAuto = 1 << 2,
    
    DSGrayscaleTransformationModeRev = NSIntegerMin
} NS_SWIFT_NAME(GrayscaleTransformationMode);

#endif /* DSCoreModes_h */
