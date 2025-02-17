/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DynamsoftCameraEnhancer/DSCameraState.h>
#import <DynamsoftCore/DSImageSourceAdapter.h>
#import <DynamsoftCore/DSImageCaptureDistanceMode.h>

@class DSCameraView;
@class DSRect;
@class DSCapabilities;
@protocol DSVideoFrameListener;
@protocol DSPhotoListener;
@protocol DSCameraStateListener;

/**
 * DSFocusMode defines the enumerations that indicates the focus mode.
 */
typedef NS_ENUM(NSInteger, DSFocusMode) {
/**
     * Lock the focus length after the auto-focus is finished.
     */
    DSFocusModeLocked,
/**
     * Enable the continuous auto-focus.
     */
    DSFocusModeContinuousAuto
} NS_SWIFT_NAME(FocusMode);

/**
 * DSCameraPosition defines the enumerations that indicates the camera position.
 */
typedef NS_ENUM(NSInteger, DSCameraPosition) {
/**
     * The default back-facing camera. It is a wide-angle camera for general usage.
     */
    DSCameraPositionBack,
/**
     * The front-facing camera.
     */
    DSCameraPositionFront,
/**
     * The back-facing ultra-wide-angle camera. It is an ultra-wide-angle camera for macro-distance capturing.
     */
    DSCameraPositionBackUltraWide API_AVAILABLE(ios(13.0)),
/**
     * A back-facing virtual camera. It is a vitural camera that can switch between the wide-angle camera and the ultra-wide-angle camera automatically.
     * Supported devices include: iPhone 13 Pro, iPhone 13 Pro Max, iPhone 14 Pro, iPhone 14 Pro Max, iPhone 15 Pro, iPhone 15 Pro Max.
     */
    DSCameraPositionBackDualWideAuto API_AVAILABLE(ios(13.0))
} NS_SWIFT_NAME(CameraPosition);

/**
 * DSResolution defines the enumerations that indicates the resolution.
 */
typedef NS_ENUM(NSInteger, DSResolution) {
/**
     * Set the video streaming to the auto selected resolution.
     */
    DSResolutionAuto,
/**
     * Set the video streaming to the 480P resolution.
     */
    DSResolution480P,
/**
     * Set the video streaming to the 720P resolution.
     */
    DSResolution720P,
/**
     * Set the video streaming to the 480P resolution.
     */
    DSResolution1080P,
/**
     * Set the video streaming to the 4K resolution.
     */
    DSResolution4K
} NS_SWIFT_NAME(Resolution);

typedef NS_OPTIONS(NSUInteger, DSEnhancedFeature) {
/**
     * Enable frame filter feature of the camera enhancer to make a filter out the low-quality frames.
     */
    DSEnhancedFeatureFrameFilter = 1 << 0,
/**
     * Enable sensor control to filter out all the frames when the device is shaking.
     */
    DSEnhancedFeatureSensorControl = 1 << 1,
/**
     * Enhanced focus helps low-end devices on focusing.
     */
    DSEnhancedFeatureEnhancedFocus = 1 << 2,
/**
     * Enable the camera zoom-in automatically when barcode is far away.
     */
    DSEnhancedFeatureAutoZoom = 1 << 3,
/**
     * Display a torch button when the environment light is low.
     */
    DSEnhancedFeatureSmartTorch = 1 << 4,
/**
     * Enable all the enhanced features.
     */
    DSEnhancedFeatureAll = NSUIntegerMax
} NS_SWIFT_NAME(EnhancedFeature);

NS_ASSUME_NONNULL_BEGIN

/**
 * The primary class of Dynamsoft Camera Enhancer that defines the camera controlling APIs.
 */
NS_SWIFT_NAME(CameraEnhancer)
@interface DSCameraEnhancer : DSImageSourceAdapter

- (instancetype)initWithView:(DSCameraView *)view;

/**
 * Set/get the DSCameraView instance that bind with this DSCameraEnhancer instance.
 */
@property (nonatomic, strong) DSCameraView *cameraView;
/**
 * Set/get the range of auto zoom.
 */
@property (nonatomic, assign) UIFloatRange autoZoomRange;

/**
 * Open the camera.
 */
- (void)open;

/**
 * Close the camera.
 */
- (void)close;

/**
 * Get the device capabilities including zoom factor, ISO, exposure time, etc.
 *
 * @return The camera state.
 */
- (DSCameraState)getCameraState;

/**
 * Set a DSCameraStateListener to receive callback when the camera state changed.
 *
 * @param [in] listener A delegate object of DSCameraStateListener to the camera state.
 */
- (void)setCameraStateListener:(nullable id<DSCameraStateListener>)listener;

/**
 * Add a DSVideoFrameListener to receive callback when video frames are output.
 *
 * @param [in] listener A delegate object of DSVideoFrameListener to receive video frame as a DSImageData.
 */
- (void)addListener:(id<DSVideoFrameListener>)listener NS_SWIFT_NAME(addListener(_:));

/**
 * Remove a DSVideoFrameListener.
 *
 * @param [in] listener A delegate object of DSVideoFrameListener.
 */
- (void)removeListener:(id<DSVideoFrameListener>)listener NS_SWIFT_NAME(removeListener(_:));

/**
 * Take a photo.
 *
 * @param [in] listener A delegate object of DSPhotoListener to receive the captured photo.
 */
- (void)takePhoto:(id<DSPhotoListener>)listener;

/**
 * Turn on the torch.
 */
- (void)turnOnTorch;

/**
 * Turn off the torch.
 */
- (void)turnOffTorch;

/**
 * Set a scan region. The video frame is cropped based on the scan region.
 *
 * @param [in] region A DSRect object.
 * @param [in,out] error A NSError pointer. An error occurs when the DSRect data is invalid.
 *
 * @return A bool value that indicates whether the scan region setting is successful.
 */
- (BOOL)setScanRegion:(nullable DSRect *)region error:(NSError * _Nullable * _Nullable)error;

/**
 * Get a scan region.
 *
 * @return A DSRect object that represent the scan region area.
 */
- (DSRect *)getScanRegion;

/**
 * Set the zoom factor of the camera. You can use getCapabilities to check the maximum available zoom factor.
 *
 * @param [in] factor The zoom factor.
 */
- (void)setZoomFactor:(CGFloat)factor;

/**
 * Get the zoom factor of the camera.
 *
 * @return The zoom factor.
 */
- (CGFloat)getZoomFactor;

/**
 * Set the focus point of interest and trigger an one-off auto-focus.
 *
 * @param [in] focusPoint The focus point of interest. The coordinate base of the point is "image".
 */
- (void)setFocus:(CGPoint)focusPoint;

/**
 * Set the focus point of interest and trigger an one-off auto-focus. After the focus, you can either lock the focal length or keep the continuous auto focus enabled by configuring the subsequent focus mode.
 *
 * @param [in] focusPoint The focus point of interest. The coordinate base of the point is "image".
 * @param [in] subsequentFocusMode The subsequent focus mode.
 */
- (void)setFocus:(CGPoint)focusPoint focusMode:(DSFocusMode)subsequentFocusMode;

/**
 * Get the currently actived focus mode.
 *
 * @return The focus mode.
 */
- (DSFocusMode)getFocusMode;

/**
 * Set the resolution. If the targeting resolution is not available for your device, a closest available resolution will be selected.
 *
 * @param resolution One of the DSResolution value.
 */
- (void)setResolution:(DSResolution)resolution;

/**
 * Get the current resolution.
 *
 * @return The current resolution.
 */
- (DSResolution)getResolution;

/**
 * Select a camera with a camera position.
 *
 * @param [in] position One of the DSCameraPosition value.
 * @param [in,out] error A NSError pointer. An error occurs when failed to switch the camera.
 *
 * @return A bool value that indicates whether the camera selection is successful.
 */
- (BOOL)selectCameraWithPosition:(DSCameraPosition)position error:(NSError * _Nullable * _Nullable)error;

/**
 * Get the camera position.
 *
 * @return The camera position.
 */
- (DSCameraPosition)getCameraPosition;

/**
 * Get the IDs of all available cameras.
 *
 * @return An array of camera IDs.
 */
- (NSArray<NSString *> *)getAllCameras DEPRECATED_MSG_ATTRIBUTE("DEPRECATED.");

/**
 * Select a camera with a camera ID.
 *
 * @param [in] cameraId One of the Camera IDs.
 * @param [in,out] error A NSError pointer. An error occurs when failed to switch the camera.
 *
 * @return A bool value that indicates whether the camera selection is successful.
 */
- (BOOL)selectCamera:(NSString *)cameraId error:(NSError * _Nullable * _Nullable)error DEPRECATED_MSG_ATTRIBUTE("DEPRECATED.");

/**
 * Get the currently actived camera.
 *
 * @return The ID of the currently actived camera.
 */
- (NSString *)getSelectedCamera DEPRECATED_MSG_ATTRIBUTE("DEPRECATED.");

- (NSUInteger)getFrameRate;

/**
 * Enable the specified enhanced features. View DSEnhancedFeatures for more details.
 *
 * @param [in] enhancedFeatures A combined value of DSEnhancedFeatures which indicates a series of enhanced features.
 */
- (void)enableEnhancedFeatures:(DSEnhancedFeature)enhancedFeatures;

/**
 * Disable the specified enhanced features. View DSEnhancedFeatures for more details.
 *
 * @param [in] enhancedFeatures A combined value of DSEnhancedFeatures which indicates a series of enhanced features.
 */
- (void)disableEnhancedFeatures:(DSEnhancedFeature)enhancedFeatures;

/**
 * Initialize system settings from a JSON file. The system settings contain more precise camera control parameters.
 *
 * @param [in] filePath The path of the JSON file.
 * @param [in,out] error A NSError pointer. An error occurs when the file path is not available or the JSON data includes invalid keys or values.
 *
 * @return A bool value that indicates whether the system settings are initialized successfully.
 */
- (BOOL)initSystemSettingsFromFile:(NSString *)filePath error:(NSError * _Nullable * _Nullable)error NS_SWIFT_NAME(initSystemSettingsFromFile(_:));

/**
 * Initialize system settings from a JSON string. The system settings contain more precise camera control parameters.
 *
 * @param [in] JsonString The JSON string.
 * @param [in,out] error A NSError pointer. An error occurs when the JSON data includes invalid keys or values.
 *
 * @return A bool value that indicates whether the system settings are initialized successfully.
 */
- (BOOL)initSystemSettingsFromString:(NSString *)JsonString error:(NSError * _Nullable * _Nullable)error NS_SWIFT_NAME(initSystemSettingsFromString(_:));

/**
 * Reset the system settings to default value.
 */
- (void)resetSystemSettings;

/**
 * Initialize enhanced settings from a JSON file. The enhanced settings contain auxiliary parameters of enhanced features.
 *
 * @param [in] filePath The JSON string.
 * @param [in,out] error A NSError pointer. An error occurs when the file path is not available or the JSON data includes invalid keys or values.
 *
 * @return A bool value that indicates whether the enhanced settings are initialized successfully.
 */
- (BOOL)initEnhancedSettingsFromFile:(NSString *)filePath error:(NSError * _Nullable * _Nullable)error NS_SWIFT_NAME(initEnhancedSettingsFromFile(_:));

/**
 * Initialize enhanced settings from a JSON string. The enhanced settings contain auxiliary parameters of enhanced features.
 *
 * @param [in] JsonString The JSON string.
 * @param [in,out] error A NSError pointer. An error occurs when the JSON data includes invalid keys or values.
 *
 * @return A bool value that indicates whether the enhanced settings are initialized successfully.
 */
- (BOOL)initEnhancedSettingsFromString:(NSString *)JsonString error:(NSError * _Nullable * _Nullable)error NS_SWIFT_NAME(initEnhancedSettingsFromString(_:));

/**
 * Reset the enhanced settings to default value.
 */
- (void)resetEnhancedSettings;

/**
 * Output the enhanced settings to a JSON string. The enhanced settings contain auxiliary parameters of enhanced features.
 *
 * @return The enhanced settings in a JSON string.
 */
- (nullable NSString *)outputEnhancedSettings;

/**
 * Output the enhanced settings to a JSON file. The enhanced settings contain auxiliary parameters of enhanced features.
 *
 * @param [in] filePath The path that you want to output the JSON file.
 * @param [in,out] error A NSError pointer. An error occurs when the file path is not available.
 *
 * @return A bool value that indicates whether the enhanced settings are output successfully.
 */
- (BOOL)outputEnhancedSettingsToFile:(NSString *)filePath error:(NSError * _Nullable * _Nullable)error NS_SWIFT_NAME(outputEnhancedSettingsToFile(_:));

/**
 * Set/get the capture distance property of the video frame. The capture distance property will be recorded by DSVideoFrameTag.
 */
@property (nonatomic, assign) DSImageCaptureDistanceMode imageCaptureDistanceMode;

/**
 * Get the device capabilities including zoom factor, ISO, exposure time, etc.
 *
 * @return A DSCapabilities object.
 */
- (DSCapabilities *)getCapabilities;

/**
 * Convert the coordinates of a DSRect under video coordinate system to a CGRect under camera view coordinate system.
 *
 * @param [in] rect The DSRect that you want to convert.
 *
 * @return A CGRect (coordinate measured in PT) converted from the DSRect.
 */
- (CGRect)convertRectToViewCoordinates:(DSRect *)rect NS_SWIFT_NAME(convertRectToViewCoordinates(_:));

/**
 * Convert the coordinates of a CGPoint under video coordinate system to another CGPoint under camera view coordinate system.
 *
 * @param [in] point The CGPoint that you want to convert.
 *
 * @return A CGPoint (coordinate measured in PT) converted from the video CGPoint measured in PT.
 */
- (CGPoint)convertPointToViewCoordinates:(CGPoint)point NS_SWIFT_NAME(convertPointToViewCoordinates(_:));

@end

NS_ASSUME_NONNULL_END
