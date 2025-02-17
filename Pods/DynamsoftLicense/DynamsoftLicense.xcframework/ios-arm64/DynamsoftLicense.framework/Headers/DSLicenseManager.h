/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - License module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The protocol that includes methods for monitoring the license verification status.
 */
NS_SWIFT_NAME(LicenseVerificationListener)
@protocol DSLicenseVerificationListener <NSObject>

/**
 * The method that triggered when license server returns the verification info.
 *
 * @param isSuccess Whether the license is verified successfully.
 * @param error A NSError pointer. It carries the error code and message that describe the reason why your license activation is failed.
 */
- (void)onLicenseVerified:(BOOL)isSuccess error:(nullable NSError *)error;

@end

/**
 * DSLicenseManager class provides a set of APIs to manage SDK licensing.
 */
NS_SWIFT_NAME(LicenseManager)
@interface DSLicenseManager : NSObject

/**
 * Initialize the license.
 *
 * @param [in] license A license key.
 * @param [in] delegate An delegate object of DSLicenseVerificationListener to monitor the license activation status.
 */
+ (void)initLicense:(NSString *)license verificationDelegate:(nullable id<DSLicenseVerificationListener>)delegate;

/**
 * Set a human readable name for the device.
 *
 * @param [in] name The name of the device.
 */
+ (void)setDeviceFriendlyName:(NSString *)name;

/**
 * Get the device UUID.
 * @return The device UUID.
 */
+ (nullable NSString *)getDeviceUUID;

@end

NS_ASSUME_NONNULL_END
