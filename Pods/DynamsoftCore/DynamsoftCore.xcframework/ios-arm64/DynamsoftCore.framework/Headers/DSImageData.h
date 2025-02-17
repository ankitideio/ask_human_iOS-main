/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSImageTag;
@class UIImage;

typedef NS_ENUM(NSInteger, DSImagePixelFormat) {
/**
     * 0:black, 1:white.
     */
    DSImagePixelFormatBinary,
/**
     * 0:black, 1:white.
     */
    DSImagePixelFormatBinaryInverted,
/**
     * 8-bit gray.
     */
    DSImagePixelFormatGrayScaled,
/**
     * NV21.
     */
    DSImagePixelFormatNV21,
/**
     * 16bit with RGB channel order stored in memory from high to low address.
     */
    DSImagePixelFormatRGB565,
/**
     * 16bit with RGB channel order stored in memory from high to low address.
     */
    DSImagePixelFormatRGB555,
/**
     * 24bit with RGB channel order stored in memory from high to low address.
     */
    DSImagePixelFormatRGB888,
/**
     * 32bit with ARGB channel order stored in memory from high to low address.
     */
    DSImagePixelFormatARGB8888,
/**
     * 48bit with RGB channel order stored in memory from high to low address.
     */
    DSImagePixelFormatRGB161616,
/**
     * 64bit with ARGB channel order stored in memory from high to low address.
     */
    DSImagePixelFormatARGB16161616,
/**
     * 32bit with ABGB channel order stored in memory from high to low address.
     */
    DSImagePixelFormatABGR8888,
/**
     * 64bit with ABGR channel order stored in memory from high to low address.
     */
    DSImagePixelFormatABGR16161616,
/**
     * 24bit with BGR channel order stored in memory from high to low address.
     */
    DSImagePixelFormatBGR888,
/**
     *  0:black, 255:white.
     */
    DSImagePixelFormatBinary8,
/**
     * NV12.
     */
    DSImagePixelFormatNV12,
/**
     *  0:white, 255:black.
     */
    DSImagePixelFormatBinary8Inverted,
} NS_SWIFT_NAME(ImagePixelFormat);

NS_ASSUME_NONNULL_BEGIN

/**
 * DSImageData class represents image data, which contains the image bytes, width, height, stride, pixel format, orientation and a tag.
 */
NS_SWIFT_NAME(ImageData)
@interface DSImageData : NSObject
/**
 * The image data content in a byte array.
 */
@property (nonatomic, copy) NSData *bytes;
/**
 * The width of the image in pixels.
 */
@property (nonatomic, assign) NSUInteger width;
/**
 * The height of the image in pixels.
 */
@property (nonatomic, assign) NSUInteger height;
/**
 * The stride (or scan width) of the image.
 */
@property (nonatomic, assign) NSUInteger stride;
/**
 * The image pixel format used in the image byte array.
 */
@property (nonatomic, assign) DSImagePixelFormat format;
/**
 * The orientation information of the image. The library is able to read the orientation information from the EXIF data of the image file.
 */
@property (nonatomic, assign) NSInteger orientation;
/**
 * The tag of the image.
 */
@property (nonatomic, strong, nullable) DSImageTag *tag;

- (instancetype)initWithBytes:(NSData *)bytes
                        width:(NSUInteger)width
                       height:(NSUInteger)height
                       stride:(NSUInteger)stride
                       format:(DSImagePixelFormat)format
                  orientation:(NSInteger)orientation
                          tag:(nullable DSImageTag *)tag;

/**
 * Transform the DSImageData to a UIImage.
 *
 * @param [in,out] error An NSError pointer. An error occurs when the BPP (bit per pixel) is not supported.
 */
- (nullable UIImage *)toUIImage:(NSError *_Nullable *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
