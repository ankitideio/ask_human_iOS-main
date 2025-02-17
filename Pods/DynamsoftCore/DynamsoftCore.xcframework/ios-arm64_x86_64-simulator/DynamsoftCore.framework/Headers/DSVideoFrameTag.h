/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <DynamsoftCore/DSImageTag.h>

typedef NS_ENUM(NSInteger, DSFrameQuality) {

    DSFrameQualityHIGH,

    DSFrameQualityLOW,

    DSFrameQualityUNKNOWN
} NS_SWIFT_NAME(FrameQuality);

NS_ASSUME_NONNULL_BEGIN

/**
 * The DSVideoFrameTag class represents a video frame tag, which is a type of image tag that is used to store additional information about a video frame. It inherits from the DSImageTag class and adds additional attributes and methods specific to video frames.
 */
NS_SWIFT_NAME(VideoFrameTag)
@interface DSVideoFrameTag : DSImageTag
/**
 * The quality of the video frame.
 */
@property (nonatomic, readonly, assign) DSFrameQuality quality;
/**
 * Whether the video frame isCropped.
 */
@property (nonatomic, readonly, assign) BOOL isCropped;
/**
 * The crop region of the video frame.
 */
@property (nonatomic, readonly, assign) CGRect cropRegion;
/**
 * The original width of the video frame.
 */
@property (nonatomic, readonly, assign) NSUInteger originalWidth;
/**
 * The original height of the video frame.
 */
@property (nonatomic, readonly, assign) NSUInteger originalHeight;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithImageId:(NSInteger)imageId
                        quality:(DSFrameQuality)quality
                      isCropped:(BOOL)isCropped
                     cropRegion:(CGRect)region
                  originalWidth:(NSUInteger)width
                 originalHeight:(NSUInteger)height;

@end

NS_ASSUME_NONNULL_END
