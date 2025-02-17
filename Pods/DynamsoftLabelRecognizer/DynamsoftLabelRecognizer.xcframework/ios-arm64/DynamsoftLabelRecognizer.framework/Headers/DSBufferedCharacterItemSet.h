/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSBufferedCharacterItem;
@class DSCharacterCluster;

NS_ASSUME_NONNULL_BEGIN

/**
 * The CBufferedCharacterItemSet class represents a set of buffered character items.
 *
 */
NS_SWIFT_NAME(BufferedCharacterItemSet)
@interface DSBufferedCharacterItemSet : NSObject

/**
 * A NSArray that contains all the buffered character items.
 */
@property (nonatomic, readonly, copy) NSArray<DSBufferedCharacterItem *> * items;

/**
 * A NSArray that contains all the character clusters.
 */
@property (nonatomic, readonly, copy) NSArray<DSCharacterCluster *> * characterClusters;

@end

NS_ASSUME_NONNULL_END
