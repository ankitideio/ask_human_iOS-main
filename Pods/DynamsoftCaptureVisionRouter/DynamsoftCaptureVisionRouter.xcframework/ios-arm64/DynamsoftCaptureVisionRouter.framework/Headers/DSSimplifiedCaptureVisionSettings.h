/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DynamsoftCore.h>

@class DSSimplifiedBarcodeReaderSettings;
@class DSSimplifiedLabelRecognizerSettings;
@class DSSimplifiedDocumentNormalizerSettings;
@class DSQuadrilateral;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSSimplifiedCaptureVisionSettings class contains settings for capturing and recognizing images with the DSCaptureVisionRouter class.
 */
NS_SWIFT_NAME(SimplifiedCaptureVisionSettings)
@interface DSSimplifiedCaptureVisionSettings : NSObject

/**
 * Specifies the type(s) of CapturedItem(s) that will be captured.
 */
@property (nonatomic, assign) DSCapturedResultItemType capturedResultItemTypes;

/**
 * Specifies the region of interest (ROI) where the image capture and recognition will take place.
 */
@property (nonatomic, nullable) DSQuadrilateral *roi;

/**
 * Specifies whether the ROI is measured in pixels or as a percentage of the image size.
 */
@property (nonatomic, assign) BOOL roiMeasuredInPercentage;

/**
 * Specifies the maximum number of parallel tasks that can be used for image capture and recognition.
 */
@property (nonatomic, assign) NSInteger maxParallelTasks;

/**
 * Specifies the maximum time (in milliseconds) allowed for image capture and recognition.
 */
@property (nonatomic, assign) NSInteger timeout;

/**
 * Specifies the settings for barcode recognition.
 */
@property (nonatomic, nullable) DSSimplifiedBarcodeReaderSettings *barcodeSettings;

/**
 * Specifies the settings for label recognition.
 */
@property (nonatomic, nullable) DSSimplifiedLabelRecognizerSettings *labelSettings;

/**
 * Specifies the settings for document detection and normalization.
 */
@property (nonatomic, nullable) DSSimplifiedDocumentNormalizerSettings* documentSettings;

/**
 * Specifies the minimum image capture interval.
 */
@property (nonatomic, assign) NSInteger minImageCaptureInterval;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
