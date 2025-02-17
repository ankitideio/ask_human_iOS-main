/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSCorner;

NS_ASSUME_NONNULL_BEGIN

/**
 *Defines the edge of candidate quadrilaterals. An edge consists of two corners.
 */
NS_SWIFT_NAME(Edge)
@interface DSEdge : NSObject
/**
 * The start corner of the edge. Defined in DSCorner.
 */
@property (nonatomic, strong) DSCorner *startCorner;
/**
 * The end corner of the edge. Defined in DSCorner.
 */
@property (nonatomic, strong) DSCorner *endCorner;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithStartCorner:(DSCorner *)startCorner endCorner:(DSCorner *)endCorner;

@end

NS_ASSUME_NONNULL_END
