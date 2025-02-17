/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Core module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSErrorDomain const _Nonnull DSErrorDomain;

typedef NS_ERROR_ENUM(DSErrorDomain, DSError) {
/**
    * Unknown error.
    */
    DSErrorUnknown = -10000,
/**
    * Not enough memory to perform the operation.
    */
    DSErrorNoMemory = -10001,
/**
    * Null pointer.
    */
    DSErrorNullPointer = -10002,
/**
    * License invalid.
    */
    DSErrorLicenseInvalid = -10003,
/**
    * License expired.
    */
    DSErrorLicenseExpired = -10004,
/**
    * File not found.
    */
    DSErrorFileNotFound = -10005,
/**
    * The file type is not supported.
    */
    DSErrorFiletypeNotSupported = -10006,
/**
    * The BPP (Bits Per Pixel) is not supported.
    */
    DSErrorBPPNotSupported = -10007,
/**
     * The index is invalid.
     */
    DSErrorIndexInvalid = - 10008,
/**
     * The input region value parameter is invalid.
     */
    DSErrorCustomRegionInvalid = -10010,
/**
    * Failed to read the image.
    */
    DSErrorImageReadFailed = -10012,
/**
    * Failed to read the TIFF image.
    */
    DSErrorTiffReadFailed = -10013,
/**
    * The DIB (Device-Independent Bitmaps) buffer is invalid.
    */
    DSErrorDIBBufferInvalid = -10018,
/**
    * Failed to read the PDF image.
    */
    DSErrorPdfReadFailed = -10021,
/**
    * The PDF DLL is missing.
    */
    DSErrorPdfDllMissing = -10022,
/**
     * The page number is invalid.
     */
    DSErrorPageNumberInvalid  = -10023,
/**
     * The custom size is invalid.
     */
    DSErrorCustomSizeInvalid = -10024,
/**
     *  timeout.
     */
    DSErrorTimeout = -10026,
/**
    * Json parse failed.
    */
    DSErrorJsonParseFailed = -10030,
/**
    * Json type invalid.
    */
    DSErrorJsonTypeInvalid = -10031,
/**
    * Json key invalid.
    */
    DSErrorJsonKeyInvalid = -10032,
/**
    * Json value invalid.
    */
    DSErrorJsonValueInvalid = -10033,
/**
    * Json name key missing.
    */
    DSErrorJsonNameKeyMissing = -10034,
/**
    * The value of the key "Name" is duplicated.
    */
    DSErrorJsonNameValueDuplicated = -10035,
/**
    * Template name invalid.
    */
    DSErrorTemplateNameInvalid = -10036,
/**
     * The name reference is invalid.
     */
    DSErrorJsonNameReferenceInvalid = -10037,
/**
     * Parameter value invalid.
     */
    DSErrorParameterValueInvalid = -10038,
/**
     * The domain of your current site does not match the domain bound in the current product key.
     */
    DSErrorDomainNotMatch = -10039,
/**
     * The reserved info does not match the reserved info bound in the current product key.
     */
    DSErrorReservedInfoNotMatch = -10040,
/**
     * The license key does not match the license content.
     */
    DSErrorLicenseKeyNotMatch = -10043,
/**
     * Failed to request the license content.
     */
    DSErrorRequestFailed = -10044,
/**
     * Failed to init the license.
     */
    DSErrorLicenseInitFailed = -10045,
/**
    * Failed to set mode's argument.
    */
    DSErrorSetModeArgumentError = -10051,
/**
     * The license content is invalid.
     */
    DSErrorLicenseContentInvalid = -10052,
/**
     * The license key is invalid.
     */
    DSErrorLicenseKeyInvalid = -10053,
/**
     * The license key has no remaining quota.
     */
    DSErrorLicenseDeviceRunsOut = -10054,
/**
    * Failed to get mode's argument.
    */
    DSErrorGetModeArgumentError = -10055,
/**
     * The Intermediate Result Types license is invalid.
     */
    DSErrorIrtLicenseInvalid = -10056,
/**
     * Failed to save file.
     */
    DSErrorFileSaveFailed = -10058,
/**
     * The stage type is invalid.
     */
    DSErrorStageTypeInvalid = -10059,
/**
     * The image orientation is invalid.
     */
    DSErrorImageOrientationInvalid = -10060,
/**
     * Complex template can't be converted to simplified settings.
     */
    DSErrorConvertComplexTemplateError = -10061,
/**
     * Reject function call while capturing in progress.
     */
    DSErrorCallRejectedWhenCapturing = -10062,
/**
    * The input image source was not found.
    */
    DSErrorNoImageSource = -10063,
/**
    * Failed to read directory.
    */
    DSErrorReadDirectoryFailed = -10064,
/**
     * [Name] Module not found.
     *
     * Name :
     *
     * DynamsoftBarcodeReader
     *
     * DynamsoftLabelRecognizer
     *
     * DynamsoftDocumentNormalizer
     */
    DSErrorModuleNotFound = -10065,
/**
     * The api does not support multi-page files. Please use FileFetcher instead.
     */
    DSErrorMultiPagesNotSupported = -10066,
/**
     * The file already exists but overwriting is disabled.
     */
    DSErrorFileAlreadyExists = -10067,
/**
    * The file path does not exist but cannot be created, or cannot be created for any other reason.
    */
    DSErrorCreateFileFailed = -10068,
/**
    * The input ImageData object contains invalid parameter(s).
    */
    DSErrorImageDataInvalid = -10069,
/**
    * The size of the input image does not meet the requirements.
    */
    DSErrorImageSizeNotMatch = -10070,
/**
    * The pixel format of the input image does not meet the requirements.
    */
    DSErrorImagePixelFormatNotMatch = -10071,
/**
    * The section level result is irreplaceable.
    */
    DSErrorSectionLevelResultIrreplaceable = -10072,
/**
    * The axis definition is incorrect.
    */
    DSErrorAxisDefinitionIncorrect = -10073,
/**
    * The result is not replaceable due to type mismatch.
    */
    DSErrorResultTypeMismatchIrreplaceable = -10074,
    
    DSErrorPDFLibraryLoadFailed = -10075,
/** 
     * The license is initialized successfully but detected invalid content in your key.
     */
    DSErrorLicenseWarning = -10076,
/**
    * No license.
    */
    DSErrorNoLicense = -20000,
/**
    * The handshake code is invalid.
    */
    DSErrorHandshakeCodeInvalid = -20001,
/**
    * Failed to read or write license cache.
    */
    DSErrorLicenseBufferFailed = -20002,
/**
    * Falied to synchronize license info wirh license tracking server.
    */
    DSErrorLicenseSyncFailed = -20003,
/**
    * Device does not match with license buffer.
    */
    DSErrorDeviceNotMatch = -20004,
/**
    * Falied to bind device.
    */
    DSErrorBindDeviceFailed = -20005,
/**
    * Instance count over limit.
    */
    DSErrorInstanceCountOverLimit = -20008,
/**
    * Trial License.
    */
    DSErrorTrialLicense = -20010,
/**
     * The license is not valid for current version.
     */
    DSErrorLicenseVersionNotMatch = -20011,
    
    DSErrorLicenseCacheUsed = -20012,
/**
    * Failed to reach License Tracking Server.
    */
    DSErrorFailedToReachDLS = -20200,
/**
     *  The barcode format is invalid.
     */
    DSErrorBarcodeFormatInvalid = -30009,
/**
     *  The QR Code license is invalid.
     */
    DSErrorQRLicenseInvalid = -30016,
/**
     *  The 1D Barcode license is invalid.
     */
    DSError1DLicenseInvalid = -30017,
/**
     *  The PDF417 license is invalid.
     */
    DSErrorPDF417LicenseInvalid = -30019,
/**
     *  The DATAMATRIX license is invalid.
     */
    DSErrorDatamatrixLicenseInvalid = -30020,
/**
     *  The custom module size is invalid.
     */
    DSErrorCustomModuleSizeInvalid = -30025,
/**
     *  The AZTEC license is invalid.
     */
    DSErrorAztecLicenseInvalid = -30041,
/**
     *  The Patchcode license is invalid.
     */
    DSErrorPatchcodeLicenseInvalid= -30046,
/**
     *  The Postal code license is invalid.
     */
    DSErrorPostalcodeLicenseInvalid = -30047,
/**
     *  The DPM license is invalid.
     */
    DSErrorDPMLicenseInvalid = -30048,
/**
     *  The frame decoding thread already exists.
     */
    DSErrorFrameDecodingThreadExists = -30049,
/**
     *  Failed to stop the frame decoding thread.
     */
    DSErrorStopDecodingThreadFailed = -30050,
/**
     *  The Maxicode license is invalid.
     */
    DSErrorMaxicodeLicenseInvalid = -30057,
/**
     *  The GS1 Databar license is invalid.
     */
    DSErrorGS1DatabarLicenseInvalid = -30058,
/**
     *  The GS1 Composite code license is invalid.
     */
    DSErrorGS1CompositeLicenseInvalid = -30059,
/**
     *  The DotCode license is invalid.
     */
    DSErrorDotcodeLicenseInvalid = -30061,
/**
     *  The Pharmacode license is invalid.
     */
    DSErrorPharmacodeLicenseInvalid = -30062,
/**
     * [Barcode Reader] No license found.
     */
    DSErrorBarcodeReaderLicenseNotFound = -30063,
/**
     *  Character Model file is not found.
     */
    DSErrorCharacterModelFileNotFound = -40100,
    
    DSErrorTextLineGroupLayoutConflict = -40101,
    
    DSErrorTextLineGroupRegexConflict = -40102,
/**
     * [Label Recognizer] No license found.
     */
    DSErrorLabelRecognizerLicenseNotFound = -40103,
/**
     * The quardrilateral is invalid.
     */
    DSErrorQuardrilateralInvalid = -50057,
/** 
     * [Document Normalizer] No license found.
     */
    DSErrorDocumentNormalizerLicenseNotFound = -50058,
/**
     * The camera module does not exist is invalid.
     */
    DSErrorCameraModuleNotExist = -60003,
/**
     * The camera ID does not exist is invalid.
     */
    DSErrorCameraIDNotExist = -60006,
/**
     * The sensor is not available.
     */
    DSErrorNoSensor = -60045,
/**
     * The camera type is not supported.
     */
    DSErrorUnSupportedCameraPosition = -60046,
/**
     * The panorama license is invalid.
     */
    DSErrorPanoramaLicenseInvalid = -70060,
/**
     *  The resource path is not exist.
     */
    DSErrorResourcePathNotExist = -90001,
/**
     *  Failed to load resource.
     */
    DSErrorResourceLoadFailed = -90002,
/**
     *  The code specification is not found.
     */
    DSErrorSpecificationNotFound = -90003,
/**
     *  The full code string is empty.
     */
    DSErrorFullCodeEmpty = -90004,
/**
     *  Failed to preprocess the full code string
     */
    DSErrorFullCodePreprocessFailed = -90005,
/**
     *  The license for parsing South Africa Driver License is invalid.
     */
    DSErrorZADLLicenseInvalid = -90006,
/**
     *  The license for parsing North America DL/ID is invalid.
     */
    DSErrorAAMVADLIDLicenseInvalid = -90007,
/**
     *  The license for parsing Aadhaar is invalid.
     */
    DSErrorAADHAARLicenseInvalid = -90008,
/**
     *  The license for parsing Machine Readable Travel Documents is invalid.
     */
    DSErrorMRTDLicenseInvalid = -90009,
/**
     *  The license for parsing Vehicle Identification Number is invalid.
     */
    DSErrorVINLicenseInvalid = -90010,
/**
     *  The license for parsing customized code type is invalid.
     */
    DSErrorCustomizedCodeTypeLicenseInvalid = -90011,
/**
     * [Code Parser] No license found.
     */
    DSErrorCodeParserLicenseNotFound = -90012,
};
