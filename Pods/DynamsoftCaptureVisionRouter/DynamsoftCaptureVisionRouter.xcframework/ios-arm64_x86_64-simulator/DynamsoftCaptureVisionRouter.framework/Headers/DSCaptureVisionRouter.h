/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Capture Vision Router module.
 *
 * Copyright © Dynamsoft Corporation.  All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCore/DynamsoftCore.h>

@class DSCaptureVisionRouter;
@class DSSimplifiedCaptureVisionSettings;

@class DSSimplifiedBarcodeReaderSettings;
@class DSSimplifiedLabelRecognizerSettings;
@class DSIntermediateResultManager;
@class DSBufferedItemsManager;
@class DSCapturedResult;

@protocol DSCapturedResultReceiver;
@protocol DSCaptureStateListener;
@protocol DSImageSourceStateListener;
@protocol DSCapturedResultFilter;


NS_ASSUME_NONNULL_BEGIN

/**
 * The DSCaptureVisionRouter class is what a user uses to interact with image-processing and semantic-processing products in their applications. It accepts an image source and returns processing results which may contain Final results or Intermediate Results.
 */
NS_SWIFT_NAME(CaptureVisionRouter)
@interface DSCaptureVisionRouter : NSObject

/**
 * Initialize an instance of CaptureVisionRouter.
 */
- (instancetype)init;

/**
 * Sets an image source to provide images for consecutive process.
 *
 * @param [in] adapter An object of DSImageSourceAdapter. You can use a internally implemented ImageSourceAdapter such as CameraEnhancer, DirectoryFetcher and FileFetcher.
 * @param [in,out] error An NSError pointer. An error occurs if the method is triggered after the capture is started.
 * @return A bool value that indicates whether the input is set successfully.
 */
- (BOOL)setInput:(nullable DSImageSourceAdapter *)adapter
           error:(NSError * _Nullable * _Nullable)error;

/**
 * Gets the attached image source adapter object of the capture vision router.
 *
 * @return The attached image source adapter object of the capture vision router.
 */
- (nullable DSImageSourceAdapter *)getInput;

/**
 * Regisiter a DSCaptureStateListener to get callback when capture state changes.
 * @param [in] listener A delegate object of DSCaptureStateListener to receive the capture state.
 */
- (void)addCaptureStateListener:(nonnull id<DSCaptureStateListener>)listener
NS_SWIFT_NAME(addCaptureStateListener(_:));

/**
 * Remove a DSCaptureStateListener.
 * @param [in] listener An object of DSCaptureStateListener.
 */
- (void)removeCaptureStateListener:(nonnull id<DSCaptureStateListener>)listener
NS_SWIFT_NAME(removeCaptureStateListener(_:));

/**
 * Regisiter a DSImageSourceStateListener to get callback when the status of DSImageSourceAdapter changes.
 *
 * @param [in] listener An object of DSImageSourceStateListener.
 */
- (void)addImageSourceStateListener:(id<DSImageSourceStateListener>)listener
NS_SWIFT_NAME(addImageSourceStateListener(_:));

/**
 * Remove a DSImageSourceStateListener.
 *
 * @param [in] listener An object of DSImageSourceStateListener.
 */
- (void)removeImageSourceStateListener:(id<DSImageSourceStateListener>)listener
NS_SWIFT_NAME(removeImageSourceStateListener(_:));

/**
 * Regisiter a DSCapturedResultReceiver to get callback when DSCapturedResult output.
 *
 * @param [in] receiver An object of DSCapturedResultReceiver.
 */
- (void)addResultReceiver:(id<DSCapturedResultReceiver>)receiver
NS_SWIFT_NAME(addResultReceiver(_:));

/**
 * Remove a DSCapturedResultReceiver.
 *
 * @param [in] receiver An object of DSCapturedResultReceiver.
 */
- (void)removeResultReceiver:(id<DSCapturedResultReceiver>)receiver
NS_SWIFT_NAME(removeResultReceiver(_:));

/**
 * Regisiter a DSCapturedResultFilter to get callback when filtered result output.
 * @param [in] filter An object of DSCapturedResultFilter.
 */
- (void)addResultFilter:(nonnull id<DSCapturedResultFilter>)filter
NS_SWIFT_NAME(addResultFilter(_:));

/**
 * Remove a DSCapturedResultFilter.
 * @param [in] filter An object of DSCapturedResultFilter.
 */
- (void)removeResultFilter:(nonnull id<DSCapturedResultFilter>)filter
NS_SWIFT_NAME(removeResultFilter(_:));

/**
 * Start capturing with the targeting template.
 *
 * @param [in] templateName The name of a template that you have previously set via initSettings or initSettingsFromFile.
 * @param [in] completionHandler A completion handler the system calls after it finishes the startCapturing.
 *         isSuccess A BOOL value that indicates whether the startCapturing operation is success.
 *         error An error object if the request fails; otherwise, nil.
 */
- (void)startCapturing:(NSString*)templateName
     completionHandler:(nullable void(^)(BOOL isSuccess, NSError *_Nullable error))completionHandler
NS_SWIFT_NAME(startCapturing(_:completionHandler:));
/**
 * Stop capturing.
 */
- (void)stopCapturing;

/**
 * Pause capturing.
 */
- (void)pauseCapturing;

/**
 * Resume capturing.
 */
- (void)resumeCapturing;

/**
 * Get the object of DSIntermediateResultManager.
 *
 * @return An object of DSIntermediateResultManager.
 */
- (DSIntermediateResultManager *)getIntermediateResultManager;

/**
 * Gets the buffered items manager to access the buffered character items.
 *
 * @return An object of BufferedItemsManager.
 */
- (DSBufferedItemsManager *)getBufferedItemsManager;

/**
 * Retrieves an array of template names.
 *
 * @return An NSArray representing the names of templates.
 */
- (NSArray<NSString *> *) getTemplateNames;

/**
 * Initialize the settings with a JSON String.
 *
 * @param [in] content A JSON string that contains capture vision settings.
 * @param [in,out] error An NSError pointer. An error occurs when:
 *     - The method is triggered after the capture is started.
 *     - You settings include invalid parameters.
 * @return A bool value that indicates whether the settings are initialized successfully.
 */
- (BOOL)initSettings:(NSString *)content
              error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(initSettings(_:));

/**
 * Initialize the settings with a JSON file.
 *
 * @param [in] file A JSON file that contains capture vision settings.
 * @param [in,out] error An NSError pointer. An error occurs when:
 *     - The method is triggered after the capture is started.
 *     - There exists invalid parameters in your settings.
 *     - Your file path is unavailable.
 * @return A bool value that indicates whether the settings are initialized successfully.
 */
- (BOOL)initSettingsFromFile:(NSString *)file
                      error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(initSettingsFromFile(_:));

/**
 * Get the object of the currently active DSSimplifiedCaptureVisionSettings.
 * @param [in,out] error An NSError pointer. An error occurs when:
 *     - The method is triggered after the capture is started.
 *     - You are using a complex template and failed to output the simplified settings object.
 * @return An object of DSSimplifiedCaptureVisionSettings.
 */
- (nullable DSSimplifiedCaptureVisionSettings *)getSimplifiedSettings:(NSString *)templateName
                                                                error:(NSError * _Nullable * _Nullable)error;

/**
 * Update capture vision settings with a object of DSSimplifiedCaptureVisionSettings.
 *
 * @param [in] templateName Specify the name of the template that you want to update.
 * @param [in] settings An object of DSSimplifiedCaptureVisionSettings.
 * @param [in,out] error An NSError pointer. An error occurs when:
 *     - The method is triggered after the capture is started.
 *     - You settings include invalid parameters.
 * @return A bool value that indicates whether the settings are uploaded successfully.
 */
- (BOOL)updateSettings:(NSString *)templateName
              settings:(nonnull DSSimplifiedCaptureVisionSettings *)settings
                 error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(updateSettings(_:settings:));

/**
 * Reset the capture vision settings.
 * @param [in,out] error An NSError pointer. An error occurs when:
 *     - The method is triggered after the capture is started.
 *     - You settings include invalid parameters.
 * @return A bool value that indicates whether the settings are reset successfully.
 */
- (BOOL)resetSettings:(NSError * _Nullable * _Nullable)error;

/**
 * Output the targeting capture vision settings to a JSON string.
 * @param [in,out] error An NSError pointer. An error occurs when:
 *     - The method is triggered after the capture is started.
 *     - The template name you input is invalid.
 * @return The capture vision settings in a JSON string.
 */
- (nullable NSString *)outputSettings:(NSString *)templateName
                                error:(NSError * _Nullable * _Nullable)error;

/**
 * Output the targeting capture vision settings to a JSON file.
 * @param [in] templateName The name of the template that you want to output.
 * @param [in] file The file path and name that you want to save the template.
 * @param [in,out] error An NSError pointer. An error occurs when:
 *     - The method is triggered after the capture is started.
 *     - The template name you input is invalid.
 *     - The file path you input is unavailable.
 * @return A BOOL value that indicates whether the template is output successfully.
 */
- (BOOL)outputSettingsToFile:(NSString *)templateName
                        file:(NSString *)file
                       error:(NSError * _Nullable * _Nullable)error
NS_SWIFT_NAME(outputSettingsToFile(_:file:));

/**
 * Implement data capture on the given file.
 * @param [in] file The file path and name that you want to implement the data capturing.
 * @param [in] templateName Specify a template with a templateName for the data capturing.
 * @return A DSCapturedResult object output by the library.
 */
- (DSCapturedResult *)captureFromFile:(NSString *)file
                         templateName:(NSString *)templateName
NS_SWIFT_NAME(captureFromFile(_:templateName:));

/**
 * Implement data capture on the given file.
 * @param [in] fileBytes A NSData that points to a file in memory.
 * @param [in] templateName Specify a template with a templateName for the data capturing.
 * @return A DSCapturedResult object output by the library.
 */
- (DSCapturedResult *)captureFromFileBytes:(NSData *)fileBytes
                              templateName:(NSString *)templateName
NS_SWIFT_NAME(captureFromFileBytes(_:templateName:));

/**
 * Implement data capture on the given file.
 * @param [in] image A UIImage.
 * @param [in] templateName Specify a template with a templateName for the data capturing.
 * @return A DSCapturedResult object output by the library.
 */
- (DSCapturedResult *)captureFromImage:(UIImage *)image
                          templateName:(NSString *)templateName
NS_SWIFT_NAME(captureFromImage(_:templateName:));

/**
 * Implement data capture on the given file.
 * @param [in] buffer A DSImageData object that contains image info.
 * @param [in] templateName Specify a template with a templateName for the data capturing.
 * @return A DSCapturedResult object output by the library.
 */
- (DSCapturedResult *)captureFromBuffer:(DSImageData *)buffer
                           templateName:(NSString *)templateName
NS_SWIFT_NAME(captureFromBuffer(_:templateName:));

@end

NS_ASSUME_NONNULL_END
