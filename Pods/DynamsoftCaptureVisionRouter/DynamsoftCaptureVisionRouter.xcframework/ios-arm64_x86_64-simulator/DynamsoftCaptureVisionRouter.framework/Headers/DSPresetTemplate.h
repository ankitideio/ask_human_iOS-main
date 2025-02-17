/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>

#ifndef DSPresetTemplate_h
#define DSPresetTemplate_h

NS_ASSUME_NONNULL_BEGIN

/**
 * DSPresetTemplate defines the enumerations that indicates the preset capture vision templates.
 */
typedef NSString * DSPresetTemplate NS_STRING_ENUM NS_SWIFT_NAME(PresetTemplate);

/**
 * The default template that performs barcode decoding, label recognizing, boundary detecting and document normalizing. The template name is "Default".
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateDefault NS_SWIFT_NAME(defaultTemplate);

/**
 * The template that enables barcode decoding only. The template name is "ReadBarcodes_Default".
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateReadBarcodes NS_SWIFT_NAME(readBarcodes);

/**
 * The template that enables label recognizing only. The template name is "RecognizeTextLines_Default".
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateRecognizeTextLines NS_SWIFT_NAME(recognizeTextLines);

/**
 * The template that enables boundary detecting only. The template name is "DetectDocumentBoundaries_Default".
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateDetectDocumentBoundaries NS_SWIFT_NAME(detectDocumentBoundaries);

/**
 * The template that enables both boundary detecting and document normalizing. The template name is "DetectAndNormalizeDocument_Default".
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateDetectAndNormalizeDocument NS_SWIFT_NAME(detectAndNormalizeDocument);

/**
 * The template that enables document normalizing only. The template name is "NormalizeDocument_Default".
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateNormalizeDocument NS_SWIFT_NAME(normalizeDocument);


/**
 * The template that enables barcode decoding and the speed performance is prioritized. The template name is  "ReadBarcodesSpeedFirst".
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateReadBarcodesSpeedFirst NS_SWIFT_NAME(readBarcodesSpeedFirst);

/**
 * The template that enables barcode decoding and the read rate performance is prioritized. The template name is  "ReadBarcodesReadRateFirst"
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateReadBarcodesReadRateFirst NS_SWIFT_NAME(readBarcodesReadRateFirst);

/**
 * This template is specially configured for single barcode decoding. The template name is  "ReadSingleBarcode"
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateReadSingleBarcode NS_SWIFT_NAME(readSingleBarcode);


/**
 * This template is specially configured for recognizing numbers from the text lines. The template name is  "RecognizeNumbers"
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateRecognizeNumbers NS_SWIFT_NAME(recognizeNumbers);

/**
 * This template is specially configured for recognizing letters from the text lines. The template name is  "RecognizeLetters"
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateRecognizeLetters NS_SWIFT_NAME(recognizeLetters);

/**
 * This template is specially configured for recognizing number and letters from the text lines. The template name is  "RecognizeNumbersAndLetters"
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateRecognizeNumbersAndLetters NS_SWIFT_NAME(recognizeNumbersAndLetters);

/**
 * This template is specially configured for recognizing number and upper case letters from the text lines. The template name is  "RecognizeNumbersAndUppercaseLetters"
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateRecognizeNumbersAndUppercaseLetters NS_SWIFT_NAME(recognizeNumbersAndUppercaseLetters);
/**
 * This template is specially configured for recognizing upper case letters from the text lines. The template name is  "RecognizeUppercaseLetters"
 */
FOUNDATION_EXPORT DSPresetTemplate const _Nonnull DSPresetTemplateRecognizeUppercaseLetters NS_SWIFT_NAME(recognizeUppercaseLetters);


NS_ASSUME_NONNULL_END

#endif
