/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Utility module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <DynamsoftUtility/DSProactiveImageSourceAdapter.h>

@class DSPDFReadingParameter;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSDirectoryFetcher class is a utility class that retrieves a list of files from a specified directory based on certain criteria. It inherits from the DSImageSourceAdapter class.
 */
NS_SWIFT_NAME(DirectoryFetcher)
@interface DSDirectoryFetcher : DSProactiveImageSourceAdapter

/**
 * Create an instance of DSDirectoryFetcher.
 *
 * @return An instance of DSDirectoryFetcher
 */
- (instancetype)init;

/**
 * Sets the directory path and filter for the file search.
 *
 * @param [in] directoryPath The directory path.
 * @param [in] filter A string that specifies file extensions. It determines which kinds of files to read. e.g ".BMP;.JPG;.GIF".
 * @param [in] recursive Specifies whether to load files recursively.
 * @param [in,out] error A NSError pointer. An error occurs when:
 *     - The directory is unavailable.
 *     - The method is triggered after the capture is started.
 *
 * @return A BOOL value that indicates whether the directory is set successfully.
 */
- (BOOL)setDirectory:(NSString *)directoryPath
              filter:(NSString *)filter
           recursive:(BOOL)recursive
               error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(setDirectory(_:filter:recursive:));

/**
 * Sets the parameters for reading PDF files.
 *
 * @param [in] para A DSPDFReadingParameter object.
 * @param [in,out] error A NSError pointer. An error occurs when:
 *     - The directory is unavailable.
 *     - The method is triggered after the capture is started.
 *
 * @return A BOOL value that indicates whether the PDF reading mode is set successfully.
 */
- (BOOL)setPDFReadingParameter:(DSPDFReadingParameter *)para
                         error:(NSError * _Nullable * _Nullable)error;

/**
 * Set the pages to read.
 * @param [in] pages An array that contains all the pages to read.
 * @param [in,out] error A NSError pointer. The error could be one of the follows:
 *     - EC_PDF_READ_FAILED
 *     - EC_IMAGE_READ_FAILED
 *     - EC_FILE_NOT_FOUND
 *     - EC_FILE_TYPE_NOT_SUPPORTED
 */
- (BOOL)setPages:(NSArray<NSNumber *> *)pages
          error:(NSError *_Nullable *_Nullable)error;


@end

NS_ASSUME_NONNULL_END
