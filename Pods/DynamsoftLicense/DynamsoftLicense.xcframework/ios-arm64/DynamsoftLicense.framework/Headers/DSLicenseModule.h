/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - License module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSLicenseModule class defines general functions of the license module.
 */
NS_SWIFT_NAME(LicenseModule)
@interface DSLicenseModule : NSObject
/**
 * Get the version of Dynamsoft License module.
 *
 * @return The version of Dynamsoft License module.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
