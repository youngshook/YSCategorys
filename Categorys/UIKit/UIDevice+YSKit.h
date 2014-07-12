/*!
    UIDevice extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIDevice (YSKit)

/// If the device is iPad.
/// Detect using userInterfaceIdiom.
- (BOOL)ys_isPad;

/// Returns if the device has a retina screen.
/// Detect using UIScreen's scale property.
- (BOOL)ys_isRetinaDisplay;

/// Returns `YES` if the current process is being debugged (either running under the debugger or has a debugger attached post facto).
//! via: https://developer.apple.com/library/mac/#qa/qa1361/_index.html
- (BOOL)ys_isBeingDebugged;

- (long long)ys_fileSystemFreeSize;
- (long long)ys_fileSystemSize;

@end
