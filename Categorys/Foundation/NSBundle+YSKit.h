/*!
    NSBundle extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSBundle (YSKit)
+ (NSString *)mainBundlePathForCaches;
+ (NSString *)mainBundlePathForPreferences;
+ (NSString *)mainBundlePathForDocuments;
+ (NSString *)mainBundlePathForTemp;
+ (NSString *)pathForMainBoundlePath:(NSString *)path;

/**
    Bundle version string, according to Info.plist file.
    CFBundleShortVersionString + CFBundleVersion
 */
- (NSString *)versionString;
@end
