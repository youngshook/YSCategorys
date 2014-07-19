/*!
    NSAttributedString extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSAttributedString (YSKit)

+ (instancetype)ys_hyperlinkFromString:(NSString *)inString withURL:(NSURL *)aURL;

+ (instancetype)ys_linkifiedAttributedStringFromString:(NSString *)string;

@end
