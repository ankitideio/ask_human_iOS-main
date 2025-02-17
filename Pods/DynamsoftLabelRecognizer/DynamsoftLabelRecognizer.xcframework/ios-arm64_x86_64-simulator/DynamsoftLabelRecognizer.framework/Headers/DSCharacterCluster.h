/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSBufferedCharacterItem;

NS_ASSUME_NONNULL_BEGIN

/**
 * The CharacterCluster class represents a character cluster generated from the buffered character items.
 */
NS_SWIFT_NAME(CharacterCluster)
@interface DSCharacterCluster : NSObject


/**
 * The character value of the character cluster.
 */
@property (nonatomic, readonly, assign) unichar character;
/**
 * The mean character item of the character cluster.
 */
@property (nonatomic, readonly, strong) DSBufferedCharacterItem * mean;

@end

NS_ASSUME_NONNULL_END
