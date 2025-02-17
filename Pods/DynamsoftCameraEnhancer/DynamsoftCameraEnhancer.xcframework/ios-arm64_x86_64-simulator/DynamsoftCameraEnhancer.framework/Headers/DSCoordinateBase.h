/*
 * This is one of the header files of Dynamsoft Capture Vision SDK - Camera Enhancer module.
 *
 * Copyright © Dynamsoft Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * DSCoordinateBase defines the enumerations that indicates the coordinate base.
 */
typedef NS_CLOSED_ENUM(NSUInteger, DSCoordinateBase) {
/**
     * Image coordinate.
     */
    DSCoordinateBaseImage,
/**
     * View coordinate.
     */
    DSCoordinateBaseView
} NS_SWIFT_NAME(CoordinateBase);
