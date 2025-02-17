/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSImageCaptureDistanceMode.h>

typedef NS_ENUM(NSInteger, DSImageTagType) {
    
    DSImageTagTypeFileImage,
    
    DSImageTagTypeVideoFrame
} NS_SWIFT_NAME(ImageTagType);

NS_ASSUME_NONNULL_BEGIN

/**
 * DSImageTag class represents an image tag that can be attached to an image in a system. It contains information about the image, such as the image ID and the image capture distance mode.
 */
NS_SWIFT_NAME(ImageTag)
@interface DSImageTag : NSObject
/**
 * The ID of the image.
 */
@property (nonatomic, readonly, assign) NSInteger imageId;
/**
 * The type of the image tag.
 */
@property (nonatomic, readonly, assign) DSImageTagType type;
/**
 * The capture distance mode of the image.
 */
@property (nonatomic, assign) DSImageCaptureDistanceMode distanceMode;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
