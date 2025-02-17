/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DynamsoftCameraEnhancer/DSCoordinateBase.h>

@class DSNote;

/**
 * DSDrawingItemState defines the enumerations that indicates the state of the drawing items.
 */
typedef NS_ENUM(NSUInteger, DSDrawingItemState) {
/**
     * The state of the DrawingItem is the default state.
     */
    DSDrawingItemStateDefault = 1 << 0,
/**
     * The state of the DrawingItem is selected.
     */
    DSDrawingItemStateSelected = 1 << 1
} NS_SWIFT_NAME(DrawingItemState);

/**
 * DSDrawingItemMediaType defines the enumerations that indicates the media type of the drawing items.
 */
typedef NS_ENUM(NSUInteger, DSDrawingItemMediaType) {
/**
     * The mediate type of the DrawingItem is rectangle.
     */
    DSDrawingItemMediaTypeRectangle = 1 << 0,
/**
     * The mediate type of the DrawingItem is quadrilateral.
     */
    DSDrawingItemMediaTypeQuadrilateral = 1 << 1,
/**
     * The mediate type of the DrawingItem is text.
     */
    DSDrawingItemMediaTypeText = 1 << 2,
/**
     * The mediate type of the DrawingItem is line.
     */
    DSDrawingItemMediaTypeLine = 1 << 3,
    
    DSDrawingItemMediaTypeArc = 1 << 4
} NS_SWIFT_NAME(DrawingItemMediaType);

NS_ASSUME_NONNULL_BEGIN

/**
 * The base class of DrawingItem. You can add DrawingItems on the DrawingLayers to draw basic graphics on the view.
 */
NS_SWIFT_NAME(DrawingItem)
@interface DSDrawingItem : NSObject
/**
 * The DrawingStyle of the DrawingItem. If a DrawingItem holds a drawingStyleId, it will not use the default style of its layer.
 */
@property (nonatomic, assign) NSUInteger drawingStyleId;
/**
 * The state of the DrawingItem.
 */
@property (nonatomic, assign) DSDrawingItemState state;
/**
 * Get the media type of the DrawingItem.
 */
@property (nonatomic, assign, readonly) DSDrawingItemMediaType mediaType;
/**
 * The coordinate base of the DrawingItem. The coordinate base is image by default.
 */
@property (nonatomic, assign) DSCoordinateBase coordinateBase;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/**
 * Add a note to the DrawingItem.
 *
 * @param [in] note The DSNote object to add.
 * @param [in] replace Whether to replace the previous one when there already exists a DSNote with the same name.
 */
- (void)addNote:(DSNote *)note replace:(BOOL)replace;

/**
 * Get the specified DSNote.
 *
 * @param [in] name The name of the DSNote.
 * @return The specified DSNote object.
 */
- (nullable DSNote *)getNote:(NSString *)name;

/**
 * Check whether the specified Note exists.
 *
 * @param [in] name The name of the DSNote.
 * @return Whether the specified Note exists.
 */
- (BOOL)hasNote:(NSString *)name;

/**
 * Update the content of the specified DSNote.
 *
 * @param [in] name The name of the DSNote.
 * @param [in] content The content to add or replace with.
 * @param [in] mergeContent If true, merge the new content to the previous content. Otherwise, replace it.
 */
- (void)updateNote:(NSString *)name
           content:(NSString *)content
      mergeContent:(BOOL)mergeContent;

/**
 * Remove the specified DSNote with the specified name.
 *
 * @param [in] name The name of the DSNote.
 */
- (void)deleteNote:(NSString *)name;

/**
 * Get all DSNotes of this DrawingItem.
 *
 * @return An array of DSNote.
 */
- (nullable NSArray<DSNote *> *)getAllNotes;

/**
 * Remove all DSNotes of this DrawingItem.
 */
- (void)clearNotes;

@end

NS_ASSUME_NONNULL_END
