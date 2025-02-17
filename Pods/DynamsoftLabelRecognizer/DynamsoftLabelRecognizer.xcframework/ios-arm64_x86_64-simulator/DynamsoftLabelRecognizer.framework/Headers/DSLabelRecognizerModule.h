/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSLabelRecognizerModule class defines general functions of the label recognizer module.
 */
NS_SWIFT_NAME(LabelRecognizerModule)
@interface DSLabelRecognizerModule : NSObject

/**
 * Get the version of Dynamsoft Label Recognizer module.
 *
 * @return The version of Dynamsoft Label Recognizer module.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
