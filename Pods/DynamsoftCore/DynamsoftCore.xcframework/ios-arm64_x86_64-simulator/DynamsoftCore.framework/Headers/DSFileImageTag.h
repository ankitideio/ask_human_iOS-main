/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSImageTag.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * FileImageTag class represents an image tag that is associated with a file. It inherits from the DSImageTag class and adds additional attributes.
 */
NS_SWIFT_NAME(FileImageTag)
@interface DSFileImageTag : DSImageTag
/**
 * The file path of the image.
 */
@property (nonatomic, readonly, copy, nullable) NSString *filePath;
/**
 * The page number of the current image in the PDF file
 */
@property (nonatomic, readonly, assign) NSUInteger pageNumber;
/**
 * The total page number of the PDF file.
 */
@property (nonatomic, readonly, assign) NSUInteger totalPages;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithImageId:(NSInteger)imageId
                       filePath:(nullable NSString *)path
                     pageNumber:(NSUInteger)number
                     totalPages:(NSUInteger)totalPages;

@end

NS_ASSUME_NONNULL_END
