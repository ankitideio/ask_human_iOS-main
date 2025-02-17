/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */
#import <Foundation/Foundation.h>

@class DSIntermediateResultExtraInfo;
@class DSIntermediateResult;
@class DSColourImageUnit;
@class DSScaledDownColourImageUnit;
@class DSGrayscaleImageUnit;
@class DSTransformedGrayscaleImageUnit;
@class DSPredetectedRegionsUnit;
@class DSEnhancedGrayscaleImageUnit;
@class DSBinaryImageUnit;
@class DSTextureDetectionResultUnit;
@class DSTextureRemovedGrayscaleImageUnit;
@class DSTextureRemovedBinaryImageUnit;
@class DSTextRemovedBinaryImageUnit;
@class DSContoursUnit;
@class DSLineSegmentsUnit;
@class DSCandidateBarcodeZonesUnit;
@class DSLocalizedBarcodesUnit;
@class DSScaledUpBarcodeImageUnit;
@class DSDeformationResistedBarcodeImageUnit;
@class DSComplementedBarcodeImageUnit;
@class DSDecodedBarcodesUnit;
@class DSTextZonesUnit;
@class DSLocalizedTextLinesUnit;
@class DSRecognizedTextLinesUnit;
@class DSLongLinesUnit;
@class DSCornersUnit;
@class DSCandidateQuadEdgesUnit;
@class DSDetectedQuadsUnit;
@class DSNormalizedImagesUnit;
@class DSShortLinesUnit;
@class DSRawTextLinesUnit;
@class DSLogicLinesUnit;
@class DSObservationParameters;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSIntermediateResultReceiver is a protocol that includes methods for monitoring the output of intermediate results.
 */
NS_SWIFT_NAME(IntermediateResultReceiver)
@protocol DSIntermediateResultReceiver <NSObject>

@optional

/**
 * Receive all section results in one DSIntermediateResult object when an algorithm task is completed.
 *
 * @param result All the section results of this task.
 * @param info The extra info of the results.
 */
- (void)onTaskResultsReceived:(DSIntermediateResult *)result
                         info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive colour images when they are output by the library.
 *
 * @param unit A DSColourImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onColourImageUnitReceived:(DSColourImageUnit *)unit
                             info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive scaled down colour images when they are output by the library.
 *
 * @param unit A DSScaledDownColourImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onScaledDownColourImageUnitReceived:(DSScaledDownColourImageUnit *)unit
                                       info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive grayscale image when they are output by the library.
 *
 * @param unit A DSGrayscaleImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onGrayscaleImageUnitReceived:(DSGrayscaleImageUnit *)unit
                                info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive transformed grayscale (colour inverted) image when they are output by the library.
 *
 * @param unit A DSTransformedGrayscaleImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onTransformedGrayscaleImageUnitReceived:(DSTransformedGrayscaleImageUnit *)unit
                                           info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive predetected region when they are output by the library.
 *
 * @param unit A DSPredetectedRegionsUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onPredetectedRegionsReceived:(DSPredetectedRegionsUnit *)unit
                                info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive enhanced grayscale image when they are output by the library.
 *
 * @param unit A DSEnhancedGrayscaleImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onEnhancedGrayscaleImageUnitReceived:(DSEnhancedGrayscaleImageUnit *)unit
                                        info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive binary image when they are output by the library.
 *
 * @param unit A DSBinaryImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onBinaryImageUnitReceived:(DSBinaryImageUnit *)unit
                             info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive texture detection result when they are output by the library.
 *
 * @param unit A DSTextureDetectionResultUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onTextureDetectionResultUnitReceived:(DSTextureDetectionResultUnit *)unit
                                        info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive grayscale image without texture when they are output by the library.
 *
 * @param unit A DSTextureRemovedGrayscaleImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onTextureRemovedGrayscaleImageUnitReceived:(DSTextureRemovedGrayscaleImageUnit *)unit
                                              info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive binary image without texture when they are output by the library.
 *
 * @param unit A DSTextureRemovedBinaryImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onTextureRemovedBinaryImageUnitReceived:(DSTextureRemovedBinaryImageUnit *)unit
                                           info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive binary image without text when they are output by the library.
 *
 * @param unit A DSTextRemovedBinaryImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onTextRemovedBinaryImageUnitReceived:(DSTextRemovedBinaryImageUnit *)unit
                                        info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive contours when they are detected by the library.
 *
 * @param unit A DSContoursUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onContoursUnitReceived:(DSContoursUnit *)unit
                          info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive line segments when they are detected by the library.
 *
 * @param unit A DSLineSegmentsUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onLineSegmentsUnitReceived:(DSLineSegmentsUnit *)unit
                              info:(DSIntermediateResultExtraInfo *)info;

// MARK: - DBR

/**
 * Receive the quadrilaterals of canditate barcode zones when they are detected by the library.
 *
 * @param unit A DSCandidateBarcodeZonesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onCandidateBarcodeZonesUnitReceived:(DSCandidateBarcodeZonesUnit *)unit
                                       info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive the localization results of the barcodes when they are detected by the library.
 *
 * @param unit A DSLocalizedBarcodesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onLocalizedBarcodesReceived:(DSLocalizedBarcodesUnit *)unit
                               info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive scaled up images of the barcodes when barcode zones are scaled up.
 *
 * @param unit A DSScaledUpBarcodeImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onScaledUpBarcodeImageUnitReceived:(DSScaledUpBarcodeImageUnit *)unit
                                      info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive images of the barcodes when deformed barcode zones are resisted.
 *
 * @param unit A DSDeformationResistedBarcodeImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onDeformationResistedBarcodeImageUnitReceived:(DSDeformationResistedBarcodeImageUnit *)unit
                                                 info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive images of the barcodes when incompleted barcode zones are completed.
 *
 * @param unit A DSComplementedBarcodeImageUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onComplementedBarcodeImageUnitReceived:(DSComplementedBarcodeImageUnit *)unit
                                          info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive DSDecodedBarcodesUnit when barcodes are decoded.
 *
 * @param unit A DSDecodedBarcodesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onDecodedBarcodesReceived:(DSDecodedBarcodesUnit *)unit
                             info:(DSIntermediateResultExtraInfo *)info;

// MARK: - DLR

/**
 * Receive text zones info when they are located.
 *
 * @param unit A DSTextZonesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onTextZonesUnitReceived:(DSTextZonesUnit *)unit
                           info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive text lines info when they are located.
 *
 * @param unit A DSLocalizedTextLinesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onLocalizedTextLinesReceived:(DSLocalizedTextLinesUnit *)unit
                                info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive text line info when they are recognized.
 *
 * @param unit A DSRecognizedTextLinesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onRecognizedTextLinesReceived:(DSRecognizedTextLinesUnit *)unit
                                 info:(DSIntermediateResultExtraInfo *)info;

// MARK: - DDN

/**
 * Receive long line units when they are detected. Based on the long lines, the library can find the corners of the quadrilateral.
 *
 * @param unit A DSLongLinesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onLongLinesUnitReceived:(DSLongLinesUnit *)unit
                           info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive corners unit when they are detected. Based on the corners, the library can find the edges of the quadrilateral.
 *
 * @param unit A DSCornersUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onCornersUnitReceived:(DSCornersUnit *)unit
                         info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive quad edges unit when they are detected. Based on the edges, the library can finally confirm the vertex coordinates of the quadrilateral.
 *
 * @param unit A DSCandidateQuadEdgesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onCandidateQuadEdgesUnitReceived:(DSCandidateQuadEdgesUnit *)unit
                                    info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive detected quadrilaterals when they are detected.
 *
 * @param unit A DSDetectedQuadsUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onDetectedQuadsReceived:(DSDetectedQuadsUnit *)unit
                           info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive normalized images when they are output.
 *
 * @param unit A DSNormalizedImagesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onNormalizedImagesReceived:(DSNormalizedImagesUnit *)unit
                              info:(DSIntermediateResultExtraInfo *)info;

/**
 * Receive line segments when they are detected by the library.
 *
 * @param unit A DSShortLinesUnit object that output by the library.
 * @param info The extra info of the results.
 */
- (void)onShortLinesUnitReceived:(DSShortLinesUnit*) unit
                            info:(DSIntermediateResultExtraInfo *)info;

/**
* The callback triggered when raw text lines are received.
*
* @param [in] unit The intermediate result unit that contains the raw text lines, of type DSRawTextLinesUnit.
* @param [in] info Additional information about the result, of type IntermediateResultExtraInfo
*
*/
- (void)onRawTextLinesReceived:(DSRawTextLinesUnit *) unit
                          info:(DSIntermediateResultExtraInfo *)info;

/**
* Called when logic lines have been received.
*
* @param [in] unit A pointer to the DSLogicLinesUnit object that contains the result.
* @param [in] info A pointer to the DSIntermediateResultExtraInfo object that contains the extra info of intermediate result.
*
*/
- (void)onLogicLinesReceived:(DSLogicLinesUnit *)unit
                        info:(DSIntermediateResultExtraInfo *)info;

/**
 * Get a DSObservationParameters object to configure the observation settings.
 *
 * @return A DSObservationParameters object.
 */
- (DSObservationParameters *)getObservationParameters;

@end

NS_ASSUME_NONNULL_END
