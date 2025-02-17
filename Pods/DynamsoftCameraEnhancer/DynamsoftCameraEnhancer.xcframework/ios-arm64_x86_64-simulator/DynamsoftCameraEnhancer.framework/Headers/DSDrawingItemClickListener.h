/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DrawingItemClickListener)
@protocol DSDrawingItemClickListener <NSObject>

- (void)onClicked:(DSDrawingItem *)item;

@end

NS_ASSUME_NONNULL_END
