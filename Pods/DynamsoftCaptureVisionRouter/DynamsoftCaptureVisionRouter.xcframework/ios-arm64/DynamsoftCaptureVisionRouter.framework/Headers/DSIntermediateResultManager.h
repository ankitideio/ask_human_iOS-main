/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSImageData;

@protocol DSIntermediateResultReceiver;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSIntermediateResultManager class manages intermediate results generated during data capturing. It provides methods to add and remove intermediate result receivers, as well as to get raw image data using an image hash id.
 */
NS_SWIFT_NAME(IntermediateResultManager)
@interface DSIntermediateResultManager : NSObject
/**
 * Adds an intermediate result receiver.
 *
 * @param receiver A delegate object of DSIntermediateResultReceiver.
 */
- (void)addResultReceiver:(id<DSIntermediateResultReceiver>)receiver NS_SWIFT_NAME(addResultReceiver(_:));
/**
 * Remove an intermediate result receiver.
 *
 * @param receiver A delegate object of DSIntermediateResultReceiver.
 */
- (void)removeResultReceiver:(id<DSIntermediateResultReceiver>)receiver NS_SWIFT_NAME(removeResultReceiver(_:));
/**
 * Gets the original image data using an image hash id.
 */
- (nullable DSImageData *)getOriginalImage:(NSString *)imageHashId;

@end

NS_ASSUME_NONNULL_END
