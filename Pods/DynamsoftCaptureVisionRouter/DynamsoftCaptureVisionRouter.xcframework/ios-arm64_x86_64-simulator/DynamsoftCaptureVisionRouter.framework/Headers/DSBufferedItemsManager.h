/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSBufferedCharacterItemSet;

NS_ASSUME_NONNULL_BEGIN

/**
 * The BufferedItemsManager class is used to manage the buffered items.
 */
NS_SWIFT_NAME(BufferedItemsManager)
@interface DSBufferedItemsManager : NSObject

/**
 * Sets the maximum number of buffered items. The Default value is 0, which means the buffer is disabled.
 * @param maxBufferedItems The maximum number of buffered items.
 */
- (void)setMaxBufferedItems:(NSInteger)maxBufferedItems;

/**
 * Gets/Sets the maximum number of buffered items. The Default value is 0, which means the buffer is disabled.
 * @return The maximum number of buffered items.
 */
- (NSInteger)getMaxBufferedItems;

/**
 * Get the buffered character items.
 * @return An object of BufferedCharacterItemSet that contains all the buffered character items.
 */
- (DSBufferedCharacterItemSet *)getBufferedCharacterItemSet;

@end

NS_ASSUME_NONNULL_END
