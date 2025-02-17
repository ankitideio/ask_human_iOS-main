/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - License module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ClientRemark)
@interface DSClientRemark : NSObject

+ (void)setEdition:(NSString *)edition;

+ (nullable NSString *)edition;

@end

NS_ASSUME_NONNULL_END
