/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DSPDFReadingMode) {
    
    DSPDFReadingModeVector = 1,
    
    DSPDFReadingModeRaster = 2,
    
    DSPDFReadingModeRev = NSIntegerMin
} NS_SWIFT_NAME(PDFReadingMode);

typedef NS_ENUM(NSInteger, DSRasterDataSource) {
/**
     * The target type is "rasterized pages". Only available for PDFReadingMode PDFRM_RASTER.
     */
    DSRasterDataSourceRasterizedPages,
/**
     * The target type is "extracted images".
     */
    DSRasterDataSourceExtractedImages,
} NS_SWIFT_NAME(RasterDataSource);

NS_ASSUME_NONNULL_BEGIN
/**
 * DSPDFReadingParameter class represents the parameters for reading a PDF file. It contains the mode of PDF reading, the DPI (dots per inch) value, and the tarGetstype.
 */
NS_SWIFT_NAME(PDFReadingParameter)
@interface DSPDFReadingParameter : NSObject
/**
 * Set the processing mode of the PDF file.
 *  You can either read the PDF info from vecter data or transfrom the PDF file into an image.
 *  The library will transform the PDF file into an image by default.
 */
@property (nonatomic, assign) DSPDFReadingMode mode;
/**
 * Set the DPI (dots per inch) of the PDF file.
 */
@property (nonatomic, assign) NSUInteger dpi;
/**
 * Set the target type of the image. The default type is page.
 */
@property (nonatomic, assign) DSRasterDataSource rasterDataSource;

- (instancetype)initWithPDFReadingMode:(DSPDFReadingMode)mode dpi:(NSUInteger)dpi rasterDataSource:(DSRasterDataSource)rasterDataSource;

@end

NS_ASSUME_NONNULL_END
