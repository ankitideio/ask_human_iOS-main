/**
 * DSNeuralNetworkModule class defines general functions of the Neural Network module.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NeuralNetworkModule)
@interface DSNeuralNetworkModule : NSObject

/**
 * Get the version of Dynamsoft Neural Network
 *
 * @return The version of Dynamsoft Neural Network.
 */
+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
