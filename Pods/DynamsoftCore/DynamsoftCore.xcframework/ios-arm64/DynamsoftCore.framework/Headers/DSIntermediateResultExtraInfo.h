/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * DSSectionType defines the enumerations that indicates the types of the algorithm sections.
 */
typedef NS_ENUM(NSInteger, DSSectionType) {
/**
     * The section type is "region predetection".
     */
    DSSectionTypeRegionPredetection,
/**
     * The section type is "barcode localization".
     */
    DSSectionTypeBarcodeLocalization,
/**
     * The section type is "barcode decoding".
     */
    DSSectionTypeBarcodeDecoding,
/**
     * The section type is "text line localization".
     */
    DSSectionTypeTextLineLocalization,
/**
     * The section type is "text line recognition".
     */
    DSSectionTypeTextLineRecognition,
/**
     * The section type is "document detection".
     */
    DSSectionTypeDocumentDetection,
/**
     * The section type is "document normalization".
     */
    DSSectionTypeDocumentNormalization
} NS_SWIFT_NAME(SectionType);

NS_ASSUME_NONNULL_BEGIN

/**
 * DSIntermediateResultExtraInfo represents the extra information for generating an intermediate result unit.
 */
NS_SWIFT_NAME(IntermediateResultExtraInfo)
@interface DSIntermediateResultExtraInfo : NSObject
/**
 * The name of the TargetROIDef object that generates the intermediate result.
 */
@property (nonatomic, readonly, copy) NSString *targetROIDefName;
/**
 * The name of the task object that generates the intermediate result.
 */
@property (nonatomic, readonly, copy) NSString *taskName;
/**
 * Whether the intermediate result is section-level result.
 */
@property (nonatomic, readonly, assign) BOOL isSectionLevelResult;
/**
 * The type of the section that generates the intermediate result.
 */
@property (nonatomic, readonly, assign) DSSectionType sectionType;

@end

NS_ASSUME_NONNULL_END
