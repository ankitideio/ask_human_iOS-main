/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Label Recognizer module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */
#import <DynamsoftCore/DynamsoftCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * DSLocalizedTextLineElement class represents a localized text line element. It inherits from the DSRegionObjectElement class.
 */
NS_SWIFT_NAME(DSLocalizedTextLineElement)
@interface DSLocalizedTextLineElement : DSRegionObjectElement

/**
 * The row number of the text line.
 */
- (NSInteger)getRowNumber;

/**
 * An array of DSQuadrilateral as the character quads.
 */
- (nullable NSArray<DSQuadrilateral *>*)getCharacterQuads;

+ (instancetype)new;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
