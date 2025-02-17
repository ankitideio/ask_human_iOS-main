/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

@class DSQuadrilateral;

NS_ASSUME_NONNULL_BEGIN

/**
 * DSCharacterResult class represents the result of a character recognition process. It contains the characters recognized (high, medium, and low confidence), their respective confidences, and the location of the character in a quadrilateral shape.
 */
NS_SWIFT_NAME(CharacterResult)
@interface DSCharacterResult : NSObject

/**The recognized character with highest confidence.*/
@property (nonatomic, readonly, assign) unichar characterH;

/**The recognized character with middle confidence.*/
@property (nonatomic, readonly, assign) unichar characterM;

/**The recognized character with lowest confidence.*/
@property (nonatomic, readonly, assign) unichar characterL;

/**The location of current character.*/
@property (nonatomic, readonly, strong, nullable) DSQuadrilateral *location;

/**The recognized character with highest confidence.*/
@property (nonatomic, readonly, assign) NSInteger characterHConfidence;

/**The recognized character with middle confidence.*/
@property (nonatomic, readonly, assign) NSInteger characterMConfidence;

/**The recognized character with lowest confidence.*/
@property (nonatomic, readonly, assign) NSInteger characterLConfidence;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
