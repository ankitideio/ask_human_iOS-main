/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSCapturedResultItem.h>

@class DSImageData;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSOriginalImageResultItem class represents a captured raw image result item. It is a derived class of DSCapturedResultItem and provides an property to get the image data.
 */
NS_SWIFT_NAME(OriginalImageResultItem)
@interface DSOriginalImageResultItem : DSCapturedResultItem

@property (nonatomic, readonly, strong, nullable) DSImageData *imageData;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
