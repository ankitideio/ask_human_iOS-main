/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Utility module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSImageData;
@class DSQuadrilateral;
@class DSLineSegment;
@class DSContour;
@class DSCorner;
@class DSEdge;

/**
 * DSImageManager class is a utility class for managing and manipulating images. It provides functionality for saving images to files and drawing various shapes on images.
 */
NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ImageManager)
@interface DSImageManager : NSObject

/**
 * Save an ImageData object as an image file.
 *
 * @param [in] imageData The ImageData object to save to an image file.
 * @param [in] path The targeting file path with the file name and extension name.
 * @param [in] overWrite A flag indicating whether to overwrite the file if it already exists. Defaults to true.
 * @param [in,out] error A NSError pointer. An error occurs when the file path is unavailable.
 *
 * @return A BOOL value that indicates whether the file is saved successfully.
 */
- (BOOL)saveToFile:(DSImageData *)imageData
              path:(NSString *)path
         overWrite:(BOOL)overWrite
             error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(saveToFile(_:path:overWrite:));

/**
 * Add quadrilaterals on the image.
 *
 * @param [in] image The ImageData to modify.
 * @param [in] quads An array of DSQuadrilateral objects to be added on the image.
 * @param [in] colour A UIColor that specifies the targeting colour.
 * @param [in] thickness The width of the border.
 *
 * @return The modified image data.
 */
- (DSImageData *)drawOnImage:(DSImageData *)image
                       quads:(NSArray<DSQuadrilateral *> *)quads
                      colour:(UIColor *)colour
                   thickness:(NSInteger)thickness
NS_SWIFT_NAME(drawOnImage(_:quads:colour:thickness:));

/**
 * Add lines on the image.
 *
 * @param [in] image The ImageData to modify.
 * @param [in] lineSegments An array of DSLineSegment objects to be added on the image.
 * @param [in] colour A UIColor that specifies the targeting colour.
 * @param [in] thickness The width of the lines.
 *
 * @return The modified image data.
 */
- (DSImageData *)drawOnImage:(DSImageData *)image
                lineSegments:(NSArray<DSLineSegment *> *)lineSegments
                      colour:(UIColor *)colour
                   thickness:(NSInteger)thickness
NS_SWIFT_NAME(drawOnImage(_:lineSegments:colour:thickness:));

/**
 * Add contours on the image.
 *
 * @param [in] image The ImageData to modify.
 * @param [in] contours An array of DSContour objects to be added on the image.
 * @param [in] colour A UIColor that specifies the targeting colour.
 * @param [in] thickness The width of the borders.
 *
 * @return The modified image data.
 */
- (DSImageData *)drawOnImage:(DSImageData *)image
                    contours:(NSArray<DSContour *> *)contours
                      colour:(UIColor *)colour
                   thickness:(NSInteger)thickness
NS_SWIFT_NAME(drawOnImage(_:contours:colour:thickness:));

/**
 * Add corners on the image.
 *
 * @param [in] image The ImageData to modify.
 * @param [in] corners An array of DSCorner objects to be added on the image.
 * @param [in] colour A UIColor that specifies the targeting colour.
 * @param [in] thickness The width of the lines.
 *
 * @return The modified image data..
 */
- (DSImageData *)drawOnImage:(DSImageData *)image
                     corners:(NSArray<DSCorner *> *)corners
                      colour:(UIColor *)colour
                   thickness:(NSInteger)thickness
NS_SWIFT_NAME(drawOnImage(_:corners:colour:thickness:));

/**
 * Add edges on the image.
 *
 * @param [in] image The ImageData to modify.
 * @param [in] edges An array of DSEdge objects to be added on the image.
 * @param [in] colour A UIColor that specifies the targeting colour.
 * @param [in] thickness The width of the edges.
 *
 * @return The modified image data.
 */
- (DSImageData *)drawOnImage:(DSImageData *)image
                       edges:(NSArray<DSEdge *> *)edges
                      colour:(UIColor *)colour
                   thickness:(NSInteger)thickness
NS_SWIFT_NAME(drawOnImage(_:edges:colour:thickness:));

@end

NS_ASSUME_NONNULL_END
