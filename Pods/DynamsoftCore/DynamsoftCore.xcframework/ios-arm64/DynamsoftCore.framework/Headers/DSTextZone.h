/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSQuadrilateral;

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSTextZone class represents a unit that contains text zones. It is derived from DSIntermediateResultUnit class and provides methods to retrieve the count and details of text zones.
 */
NS_SWIFT_NAME(TextZone)
@interface DSTextZone : NSObject

@property (nonatomic, strong) DSQuadrilateral *location;

@property (nonatomic, copy, nullable) NSArray<NSNumber *> *charContoursIndices;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithLocation:(DSQuadrilateral *)location
         charContoursIndiceArray:(nullable NSArray<NSNumber *> *)charContoursIndices;

@end

NS_ASSUME_NONNULL_END
