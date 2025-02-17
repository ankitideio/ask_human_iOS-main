/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Code Parser module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSParsedResultItem;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCodeParser class defines methods for content parsing and settings configuration.
 */
NS_SWIFT_NAME(CodeParser)
@interface DSCodeParser : NSObject

/**
 * Create an instance of DSCodeParser.
 *
 * @return An instance of DSCodeParser.
 */
- (instancetype)init;

/**
 * Initialize the settings from a JSON string.
 * @param [in] content A JSON string as the settings.
 * @return A BOOL value that indicates whether the settings is initialized successfully.
 */
- (BOOL)initSettings:(NSString *)content
                error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(initSettings(_:));

/**
 * Initialize the settings from a JSON file.
 * @param [in] filePath A JSON string as the file path.
 * @return A BOOL value that indicates whether the settings is initialized successfully.
 */
- (BOOL)initSettingsFromFile:(NSString *)filePath
                             error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(initSettingsFromFile(_:));

/**
 * Reset the settings.
 */
- (void)resetSettings;

/**
 * Parse the content.
 * @param [in] bytes A JSON string as the file path.
 * @param [in,out] error A NSError pointer. An error occurs when failing to parse the content.
 * @return A BOOL value that indicates whether the content is parsed successfully.
 */
- (nullable DSParsedResultItem *)parse:(NSData *)bytes
                       taskSettingName:(NSString *)templateName
                                 error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(parse(_:taskSettingName:)) __attribute__((swift_error(nonnull_error)));

@end

NS_ASSUME_NONNULL_END
