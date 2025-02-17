/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSRegionObjectElement.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSPredetectedRegionElement class represents a region element that has been pre-detected in an image. It is a subclass of the DSRegionObjectElement
 */
NS_SWIFT_NAME(PredetectedRegionElement)
@interface DSPredetectedRegionElement : DSRegionObjectElement
/**
 * The name of the detection mode used to detect this region element.
 */
- (NSString *)getModeName;

+ (instancetype)new;
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
