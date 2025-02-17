/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, DSIntermediateResultUnitType) {
    
    DSIntermediateResultUnitTypeNull = 0,
    
    DSIntermediateResultUnitTypeColourImage = 1 << 0,
    
    DSIntermediateResultUnitTypeScaledDownColourImage = 1 << 1,
    
    DSIntermediateResultUnitTypeGrayscaleImage = 1 << 2,
    
    DSIntermediateResultUnitTypeTransformedGrayscaleImage = 1 << 3,
    
    DSIntermediateResultUnitTypeEnhancedGrayscaleImage = 1 << 4,
    
    DSIntermediateResultUnitTypePredetectedRegions = 1 << 5,
    
    DSIntermediateResultUnitTypeBinaryImage = 1 << 6,
    
    DSIntermediateResultUnitTypeTextureDetectionResult = 1 << 7,
    
    DSIntermediateResultUnitTypeTextureRemovedGrayscaleImage = 1 << 8,
    
    DSIntermediateResultUnitTypeTextureRemovedBinaryImage = 1 << 9,
    
    DSIntermediateResultUnitTypeContours = 1 << 10,
    
    DSIntermediateResultUnitTypeLineSegments = 1 << 11,
    
    DSIntermediateResultUnitTypeTextZones = 1 << 12,
    
    DSIntermediateResultUnitTypeTextRemovedBinaryImage = 1 << 13,
    
    DSIntermediateResultUnitTypeCandidateBarcodeZones = 1 << 14,
    
    DSIntermediateResultUnitTypeLocalizedBarcodes = 1 << 15,
    
    DSIntermediateResultUnitTypeScaledUpBarcodeImage = 1 << 16,
    
    DSIntermediateResultUnitTypeDeformationResistedBarcodeImage = 1 << 17,
    
    DSIntermediateResultUnitTypeComplementedBarcodeImage = 1 << 18,
    
    DSIntermediateResultUnitTypeDecodedBarcodes = 1 << 19,
    
    DSIntermediateResultUnitTypeLongLines = 1 << 20,
    
    DSIntermediateResultUnitTypeCorners = 1 << 21,
    
    DSIntermediateResultUnitTypeCandidateQuadEdges = 1 << 22,
    
    DSIntermediateResultUnitTypeDetectedQuads = 1 << 23,
    
    DSIntermediateResultUnitTypeLocalizedTextLines = 1 << 24,
    
    DSIntermediateResultUnitTypeRecognizedTextLine = 1 << 25,
    
    DSIntermediateResultUnitTypeNormalizedImages = 1 << 26,

    DSIntermediateResultUnitTypeShortLines = 1 << 27,
    
    DSIntermediateResultUnitTypeRawTextLines = 1 << 28,
    
    DSIntermediateResultUnitTypeLogicLines = 1 << 29,
    
    DSIntermediateResultUnitTypeAll = NSUIntegerMax
} NS_SWIFT_NAME(IntermediateResultUnitType);
