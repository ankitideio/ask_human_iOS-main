/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSIntermediateResultUnit;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSIntermediateResult class represents a container containing a collection of DSIntermediateResultUnit objects
 */
NS_SWIFT_NAME(IntermediateResult)
@interface DSIntermediateResult : NSObject
/**
 * An array of DSIntermediateResultUnit objects.
 */
@property (nonatomic, readonly, copy, nullable) NSArray<DSIntermediateResultUnit *> *units;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
