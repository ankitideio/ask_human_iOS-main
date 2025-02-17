/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSImageData;
@protocol DSImageSourceErrorListener;

typedef NS_ENUM(NSInteger, DSBufferOverflowProtectionMode) {
/**
    * New images are blocked when the buffer is full.
    */
    DSBufferOverflowProtectionModeBlock,
/**
    * New images are appended at the end, and oldest images are pushed out from the beginning if the buffer is full.
    */
    DSBufferOverflowProtectionModeUpdate,
} NS_SWIFT_NAME(BufferOverflowProtectionMode);

typedef NS_ENUM(NSInteger, DSColourChannelUsageType) {
    /**
     * The colour channel is set autometically.
     */
    DSColourChannelUsageTypeAUTO,
/**
     * The colour channel is set to full channel.
     */
    DSColourChannelUsageTypeFullChannel,
/**
     * The colour channel is set to Y channel only.
     */
    DSColourChannelUsageTypeYChannelOnly,
/**
     * The colour channel is set to R channel (of RGB) only.
     */
    DSColourChannelUsageTypeRGBRChannelOnly,
/**
     * The colour channel is set to G channel (of RGB) only.
     */
    DSColourChannelUsageTypeRGBGChannelOnly,
/**
     * The colour channel is set to B channel (of RGB) only.
     */
    DSColourChannelUsageTypeRGBBChannelOnly
} NS_SWIFT_NAME(ColourChannelUsageType);

NS_ASSUME_NONNULL_BEGIN

/**
 * DSImageSourceAdapter class provides an interface for fetching and buffering images. It is an abstract class that needs to be implemented by a concrete class to provide actual functionality.
 */
NS_SWIFT_NAME(ImageSourceAdapter)
@interface DSImageSourceAdapter : NSObject
/**
 * The property defines the maximum capability of the Video Buffer.
 */
@property (nonatomic, assign) NSUInteger maxImageCount;
/**
 * Sets a mode that determines the action to take when there is a new incoming image and the buffer is full. You can either block the Video Buffer or push out the oldest image and append a new one.
 */
@property (nonatomic, assign) DSBufferOverflowProtectionMode bufferOverflowProtectionMode;
/**
 * The property defines current image count in the Video Buffer.
 */
@property (nonatomic, readonly, assign) NSUInteger imageCount;
/**
 * The read only property indicates whether the Video Buffer is empty.
 */
@property (nonatomic, readonly, assign, getter=isBufferEmpty) BOOL bufferEmpty NS_SWIFT_NAME(isBufferEmpty);
/**
 * The usage type of a color channel in an image.
 */
@property (nonatomic, assign) DSColourChannelUsageType colourChannelUsageType;

/**
 * Determines whether there are more images left to fetch.
 */
- (void)setImageFetchState:(BOOL)state;

/**
 * Get an image from the Video Buffer.
 *
 * @return An object of DSImageData.
 *     * If an image is set as the "next image" by method setNextImageToReturn, return that image.
 *     * If no image is set as the "next image", return the latest image.
 */
- (nullable DSImageData *)getImage;

/**
 * Start fetching images from the source to the Video Buffer of ImageSourceAdapter.
 */
- (void)startFetching;

/**
 * Stop fetching images from the source to the Video Buffer of ImageSourceAdapter.
 */
- (void)stopFetching;

/**
 * Specify the next image that is returned by method getImage.
 *
 * @param [in] imageId The imageId of image you want to set as the "next image".
 * @param [in] keepInBuffer Set this value to true so that the "next image" is protected from being pushed out before is it returned by method getImage.
 * @return A BOOL value that indicates whether the specified image is successfully set as the "next image".
 */
- (BOOL)setNextImageToReturn:(NSInteger)imageId keepInBuffer:(BOOL)keepInBuffer;

/**
 * Check the availability of the specified image.
 *
 * @param [in] imageId The imageId of image you want to check the availability.
 * @return A BOOL value that indicates whether the specified image is found in the video buffer.
 */
- (BOOL)hasImage:(NSInteger)imageId;

/**
 * Adds an image to the buffer of the adapter.
 *
 * @param [in] image The DSImageData object to add.
 */
- (void)addImageToBuffer:(DSImageData *)image NS_SWIFT_NAME(addImageToBuffer(_:));

/**
 * Clears the image buffer.
 */
- (void)clearBuffer;

/**
 * Regisiter a DSImageSourceErrorListener to get callback when error occurs in the ImageSourceAdapter.
 * @param [in] listener A delegate object of DSImageSourceErrorListener to receive the ImageSourceAdapter error.
 */
- (void)setErrorListener:(nullable id<DSImageSourceErrorListener>)listener;

@end

NS_ASSUME_NONNULL_END
