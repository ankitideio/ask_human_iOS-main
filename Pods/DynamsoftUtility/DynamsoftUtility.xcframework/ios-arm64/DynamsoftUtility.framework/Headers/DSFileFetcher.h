/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Utility module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DynamsoftCore/DSImageSourceAdapter.h>

@class DSImageData;
@class DSPDFReadingParameter;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSFileFetcher class is a utility class that partitions a multi-page image file into multiple independent ImageData objects. It inherits from the DSImageSourceAdapter class
 */
NS_SWIFT_NAME(FileFetcher)
@interface DSFileFetcher : DSImageSourceAdapter

- (instancetype)init;

/**
* Sets the file with a file path.
*
* @param [in] filePath The filePath.
* @param [in,out] error A NSError pointer. An error occurs when fail to load the filePath.
*/
- (BOOL)setFileWithPath:(NSString *)filePath
                 error:(NSError *_Nullable *_Nullable)error
NS_SWIFT_NAME(setFileWithPath(_:));

/**
* Sets the file with a file bytes.
*
* @param [in] fileBytes The file bytes.
* @param [in,out] error A NSError pointer. An error occurs when fail to load the bytes.
*/
- (BOOL)setFileWithBytes:(NSData *)fileBytes
                   error:(NSError *_Nullable *_Nullable)error
NS_SWIFT_NAME(setFileWithBytes(_:));

/**
* Sets the file with a DSImageData object.
*
* @param [in] buffer The image data.
* @param [in,out] error A NSError pointer. An error occurs when fail to load the buffer.
*/
- (BOOL)setFileWithBuffer:(DSImageData *)buffer
                    error:(NSError *_Nullable *_Nullable)error
NS_SWIFT_NAME(setFileWithBuffer(_:));

/**
* Sets the file with an UIImage.
*
* @param [in] image A UIImage.
* @param [in,out] error A NSError pointer. An error occurs when fail to load the image.
*/
- (BOOL)setFileWithImage:(UIImage *)image
                   error:(NSError *_Nullable *_Nullable)error
NS_SWIFT_NAME(setFileWithImage(_:));

/**
 * Sets the parameters of PDF reading.
 *
 * @param [in] para The parameter object for reading PDF files.
 * @param [in,out] error A NSError pointer. An error occurs when:
 *     - The directory is unavailable.
 *     - The method is triggered after the capture is started.
 * @return A BOOL value that indicates whether the PDF reading mode is set successfully.
 */
- (BOOL)setPDFReadingParameter:(DSPDFReadingParameter *)para
                         error:(NSError * _Nullable * _Nullable)error;

/**
 * Whether there is a next image to fetch.
 *
 * @return A bool value that indicates whether there is a next image to fetch.
 */
- (BOOL)hasNextImageToFetch;

/**
 * Get the image data of the image.
 *
 * @return A DSImageData as the image.
 */
- (DSImageData *)getImage;

/**
 * Set the pages to read.
 * @param [in] pages An array that contains all the pages to read.
 * @param [in,out] error A NSError pointer. The error could be one of the follows:
 *     - EC_PDF_READ_FAILED
 *     - EC_IMAGE_READ_FAILED
 *     - EC_FILE_NOT_FOUND
 *     - EC_FILE_TYPE_NOT_SUPPORTED
 */
-(BOOL)setPages:(NSArray<NSNumber *> *)pages
          error:(NSError *_Nullable *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
