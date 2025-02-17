/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSImageData;
NS_ASSUME_NONNULL_BEGIN

/**
 * The BufferedCharacterItem class represents a buffered character item.
 */
NS_SWIFT_NAME(BufferedCharacterItem)
@interface DSBufferedCharacterItem : NSObject

/**
 * The character value of the buffered character.
 */
@property (nonatomic, readonly, assign) unichar character;

/**
 * The image data of the buffered character.
 */
@property (nonatomic, readonly, strong) DSImageData * image;


/**
 * The property represents all buffered character features in a dictionary. The values of the dictionary are float type.
 */
@property (nonatomic, readonly, copy) NSDictionary<NSNumber *, NSNumber *> * features;

@end

NS_ASSUME_NONNULL_END
