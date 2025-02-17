/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSVector4 class represents a 4D vector.
 */
NS_SWIFT_NAME(Vector4)
@interface DSVector4 : NSObject
/**
 * An array with 4 int values as a 4D vector.
 */
@property (nonatomic, copy, readonly) NSArray *values;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithIntegerValue:(NSInteger)v1
                                  v2:(NSInteger)v2
                                  v3:(NSInteger)v3
                                  v4:(NSInteger)v4;

@end

NS_ASSUME_NONNULL_END
