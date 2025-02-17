/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSIntermediateResultUnit.h>

@class DSQuadrilateral;
@class DSTextZone;

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSTextZonesUnit class represents a unit that contains text zones. It is derived from DSIntermediateResultUnit class and provides methods to retrieve the count and details of text zones.
 */
NS_SWIFT_NAME(TextZonesUnit)
@interface DSTextZonesUnit : DSIntermediateResultUnit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * An array of DSQuadrilaterals as text zones.
 */
- (nullable NSArray<DSTextZone *> *)getTextZones;

- (NSInteger)getCount;

- (nullable DSTextZone *)getTextZone:(NSInteger)index;

- (void)removeAllTextZones;

- (NSInteger)removeTextZone:(NSInteger)index;

- (NSInteger)addTextZone:(DSTextZone *)textZone
   matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

- (NSInteger)setTextZone:(NSInteger)index
                textZone:(DSTextZone *)textZone
   matrixToOriginalImage:(CGAffineTransform)matrixToOriginalImage;

@end

NS_ASSUME_NONNULL_END
