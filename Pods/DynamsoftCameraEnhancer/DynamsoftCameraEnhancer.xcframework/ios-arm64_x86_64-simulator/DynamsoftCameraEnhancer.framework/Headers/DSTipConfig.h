/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCameraEnhancer/DSCoordinateBase.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(TipConfig)
@interface DSTipConfig : NSObject

@property (nonatomic, assign) CGPoint topLeftPoint;

@property (nonatomic, assign) NSUInteger width;

@property (nonatomic, assign) NSUInteger duration;

@property (nonatomic, assign) DSCoordinateBase coordinateBase;

- (instancetype)initWithTopLeftPoint:(CGPoint)point
                               width:(NSUInteger)width
                            duration:(NSUInteger)duration;

@end

NS_ASSUME_NONNULL_END
