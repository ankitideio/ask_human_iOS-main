/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
* DSSimplifiedLabelRecognizerSettings class contains settings for label recognizing. It is a sub-parameter of DSSimplifiedCaptureVisionSettings.
*/
NS_SWIFT_NAME(SimplifiedLabelRecognizerSettings)
@interface DSSimplifiedLabelRecognizerSettings : NSObject

/**
 * Set the grayscale transformation mode with an array of DSGrayscaleTransformationMode. It controls whether to decode the inverted text.
 */
@property (nonatomic, copy, nullable) NSArray *grayscaleTransformationModes;

/**
 * Set the grayscale enhancement mode with an array of DSGrayscaleEnhancementModes.
 */
@property (nonatomic, copy, nullable) NSArray *grayscaleEnhancementModes;

/**
 * Specify a character model by its name.
 */
@property (nonatomic, copy, nullable) NSString *characterModelName;

/**
 * Set the RegEx pattern of the text line string to filter out the unqualified results.
 */
@property (nonatomic, copy, nullable) NSString *lineStringRegExPattern;

/**
 * Set the maximum available threads count in one label recognition task.
 */
@property (nonatomic, assign) NSInteger maxThreadsInOneTask;

/**
 * Set the threshold for image shrinking.
 */
@property (nonatomic, assign) NSInteger scaleDownThreshold;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
