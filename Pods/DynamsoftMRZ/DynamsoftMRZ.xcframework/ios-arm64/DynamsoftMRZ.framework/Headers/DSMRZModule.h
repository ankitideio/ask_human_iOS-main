
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSMRZModule class defines general functions of the MRZ module..
 */
NS_SWIFT_NAME(MRZModule)
@interface DSMRZModule : NSObject

/**
 * Get the version of Dynamsoft MRZ.
 *
 * @return The version of Dynamsoft MRZ.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
