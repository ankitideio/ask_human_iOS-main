/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

typedef NS_ENUM(NSInteger, DSCrossVerificationStatus) {
    /** The cross verification has not been performed yet. */
    DSCrossVerificationStatusNotVerified,
    /** The cross verification has been passed successfully. */
    DSCrossVerificationStatusPassed,
    /** The cross verification has failed. */
    DSCrossVerificationStatusFailed
} NS_SWIFT_NAME(CrossVerificationStatus);
