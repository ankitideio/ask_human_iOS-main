/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Note)
@interface DSNote : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *content;

- (instancetype)initWithName:(NSString *)name content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
