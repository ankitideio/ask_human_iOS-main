/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSOriginalImageResultItem;
@class DSDecodedBarcodesResult;
@class DSRecognizedTextLinesResult;
@class DSDetectedQuadsResult;
@class DSNormalizedImagesResult;
@class DSParsedResult;

NS_SWIFT_NAME(CapturedResultFilter)
@protocol DSCapturedResultFilter <NSObject>

@optional

- (void)onOriginalImageResultReceived:(DSOriginalImageResultItem *)result;

- (void)onDecodedBarcodesReceived:(DSDecodedBarcodesResult *)result;

- (void)onRecognizedTextLinesReceived:(DSRecognizedTextLinesResult *)result;

- (void)onDetectedQuadsReceived:(DSDetectedQuadsResult *)result;

- (void)onNormalizedImagesReceived:(DSNormalizedImagesResult *)result;

- (void)onParsedResultsReceived:(DSParsedResult *)result;

@end
