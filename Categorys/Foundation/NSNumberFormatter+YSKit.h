/*!
    NSNumberFormatter extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (YSKit)

/** Returns an NSNumberFormatter with specified significant digits config.

   @param min The minimum number of significant digits for the formatter.
   @param max The maximum number of significant digits for the formatter.

   @return An NSNumberFormatter with specified significant digits config.
 */
+ (NSNumberFormatter *)ys_significantFormatterWithMinimumDigits:(NSUInteger)min maximumDigits:(NSUInteger)max;

/** Returns a string containing the formatted value of the provided file size.

   @param bytes The value will be parsed.
   @param isBinaryUnites signaling whether to calculate file size in binary units (1024) or base ten units (1000).

   @return A formated string.
 */
+ (NSString *)ys_formatedFileSizeStringWithBytes:(long long)bytes useBinaryUnites:(BOOL)isBinaryUnites;

/** Returns a string containing the formatted value of the provided float value.

   @param floatVaule A float value that is parsed to create the returned string object.

   @return A string containing the formatted value of number using the receiver’s current settings.
 */
- (NSString *)ys_stringFromFloat:(float)floatVaule;

@end
