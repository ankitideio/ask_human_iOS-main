/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Code Parser module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <DynamsoftCore/DynamsoftCore.h>

/**
 * DSMappingStatus defines enumerations that indicates the mapping status.
 */
typedef NS_ENUM(NSInteger, DSMappingStatus)
{
    /**
     * The field has no mapping specified.
     */
    DSMappingStatusNone = 0,
    /**
     * Find a mapping for the field value.
     */
    DSMappingStatusSucceeded = 1,
    /**
     * Failed to find a mapping for the field value.
     */
    DSMappingStatusFailed = 2
}NS_SWIFT_NAME(MappingStatus);


/**
 * DSValidationStatus defines enumerations that indicates the validation status.
 */
typedef NS_ENUM(NSInteger, DSValidationStatus)
{
    /**
     * The field has no validation specified.
     */
    DSValidationStatusNone = 0,
    /**
     * Find a validation for the field value.
     */
    DSValidationStatusSucceeded = 1,
    /**
     * The validation for the field has been failed.
     */
    DSValidationStatusFailed = 2
}NS_SWIFT_NAME(ValidationStatus);

NS_ASSUME_NONNULL_BEGIN


/**
 * DSParsedResultItem class represents a parsed result item parsed by code parser engine. It is derived from DSCapturedResultItem.
 */
NS_SWIFT_NAME(ParsedResultItem)
@interface DSParsedResultItem : DSCapturedResultItem

/**
 * A NSDictionary contains the names and values of the parsed fields.
 */
@property (nonatomic, readonly, copy) NSDictionary<NSString *, NSString *> *parsedFields;

/**
 * The parsed result as a JSON formatted string.
 */
@property (nonatomic, readonly, copy) NSString *jsonString;

/**
 * The code type of the parsed result.
 */
@property (nonatomic, readonly, copy) NSString *codeType;

/**
 * The value of a specified field from the parsed result.
 */
- (NSString *)getFieldValue:(NSString *)fieldName;

/**
 * Retrieves the raw value of a specified field.
 * @param fieldName The name of the field whose value is being requested.
 *
 * @returns The value of the field.
 */
- (NSString *)getFieldRawValue:(NSString *)fieldName;

/**
 * The mapping status of a specified field from the parsed result.
 */
- (DSMappingStatus)getFieldMappingStatus:(NSString *)fieldName;

/**
 * The validation status of a specified field from the parsed result.
 */
- (DSValidationStatus)getFieldValidationStatus:(NSString *)fieldName;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
