/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Utility module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DSCapturedResultItem.h>
#import <DynamsoftCaptureVisionRouter/DSCapturedResultFilter.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSMultiFrameResultCrossFilter class is responsible for filtering captured results.
 */
NS_SWIFT_NAME(MultiFrameResultCrossFilter)
@interface DSMultiFrameResultCrossFilter : NSObject<DSCapturedResultFilter>

/**
 * Enable duplicate filter feature to filter out the duplicate results in the period of duplicateForgetTime for video streaming recognition.
 * @param resultItemType Specifies a targeting captured result type.
 * @param isEnabled A BOOL value that indicates whether to enable the duplicate filter feature.
 */
- (void)enableResultDeduplication:(DSCapturedResultItemType)resultItemType
                        isEnabled:(BOOL)isEnabled;

/**
 * Enable result verification feature to improve the accuracy of video streaming recognition results.
 * @param resultItemType Specifies a targeting captured result type.
 * @param isEnabled A BOOL value that indicates whether to enable the result verification feature.
 */
- (void)enableResultCrossVerification:(DSCapturedResultItemType)resultItemType
                            isEnabled:(BOOL)isEnabled;

/**
* Enable the to-the-latest overlapping feature. The output captured result will become a combination of the recent results if the latest frame is proved to be similar with the previous.
*
* @param [in] resultItemTypes The or value of the captured result item types.
* @param [in] isEnabled Set whether to enable the to-the-latest overlapping feature.
*
*/
- (void)enableLatestOverlapping:(DSCapturedResultItemType)resultItemTypes
                      isEnabled:(BOOL)isEnabled;

/**
 * Sets the duplicate forget time for the specific captured result item types.
 * @param resultItemType Specifies a targeting captured result type.
 * @param duplicateForgetTime The duplicate forget time of the specified capture result type.
 */
- (void)setDuplicateForgetTime:(DSCapturedResultItemType)resultItemType
           duplicateForgetTime:(NSInteger)duplicateForgetTime;

/**
 * Gets the duplicate forget time for the specific captured result item types.
 * @param resultItemType Specifies a targeting captured result type.
 * @return The duplicate forget time of the specified capture result type.
 */
- (NSInteger)getDuplicateForgetTime:(DSCapturedResultItemType)resultItemType;

/**
 * Whether the duplicate filter feature is enabled for the specific result item type.
 * @param resultItemType Specifies a targeting captured result type.
 * @return A BOOL value that indicates whether the duplicate filter feature is enabled for the specific result item type.
 */
- (BOOL)isResultDeduplicationEnabled:(DSCapturedResultItemType)resultItemType;

/**
 * Whether the result verification feature is enabled for the specific result item type.
 * @param resultItemType Specifies a targeting captured result type.
 * @return A BOOL value that indicates whether the result verification feature is enabled for the specific result item type.
 */
- (BOOL)isResultCrossVerificationEnabled:(DSCapturedResultItemType)resultItemType;

/**
* Determines whether the to-the-latest overlapping feature is enabled for the specific result item type.
*
* @param [in] resultItemTypes The specific captured result item type.
* @return Returns a bool value indicating whether the to-the-latest overlapping feature is enabled for the specific result item type.
*
*/
- (BOOL)isLatestOverlappingEnabled:(DSCapturedResultItemType)resultItemTypes;

/**
* Set the max referencing frames count for the to-the-latest overlapping feature.
*
* @param [in] resultItemTypes Specifies one or multiple specific result item types, which can be defined using CapturedResultItemType.
* @param [in] maxOverlappingFrames The max referencing frames count for the to-the-latest overlapping feature.
*/
- (void)setMaxOverlappingFrames:(DSCapturedResultItemType)resultItemTypes
           maxOverlappingFrames:(NSInteger)maxOverlappingFrames;

/**
* Get the max referencing frames count for the to-the-latest overlapping feature.
*
* @param [in] resultItemType Specifies a specific result item type, which can be defined using CapturedResultItemType.
*
* @return Returns the max referencing frames count for the to-the-latest overlapping feature.
*/
- (NSInteger)getMaxOverlappingFrames:(DSCapturedResultItemType)resultItemType;

@end

NS_ASSUME_NONNULL_END
