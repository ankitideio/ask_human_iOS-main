/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSCapturedResult;
@class DSOriginalImageResultItem;
@class DSDecodedBarcodesResult;
@class DSRecognizedTextLinesResult;
@class DSDetectedQuadsResult;
@class DSNormalizedImagesResult;
@class DSParsedResult;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(CapturedResultReceiver)
@protocol DSCapturedResultReceiver <NSObject>

@optional

- (void)onCapturedResultReceived:(DSCapturedResult *)result;

- (void)onOriginalImageResultReceived:(DSOriginalImageResultItem *)result;

- (void)onDecodedBarcodesReceived:(DSDecodedBarcodesResult *)result;

- (void)onRecognizedTextLinesReceived:(DSRecognizedTextLinesResult *)result;

- (void)onDetectedQuadsReceived:(DSDetectedQuadsResult *)result;

- (void)onNormalizedImagesReceived:(DSNormalizedImagesResult *)result;

- (void)onParsedResultsReceived:(DSParsedResult *)result;

@end

NS_ASSUME_NONNULL_END
