/*!
    NSDateFormatter extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSDateFormatter (YSKit)

/** Returns a date formatter object which has a GMT date format.

   @return A cached `NSDateFormatter` object.
 */
+ (NSDateFormatter *)ys_GMTFormatter;

/** Returns a date formatter object which was set with current locale.

   The data format is `yyyy'-'MM'-'dd' 'HH':'mm':'ss`.

   @return A cached `NSDateFormatter` object.

   @see `currentLocaleFormatterOnlyDate`
 */
+ (NSDateFormatter *)ys_currentLocaleFormatter;

/** Returns a date formatter object which was set with current locale.

   The data format is `yyyy'-'MM'-'dd`.

   @return A cached `NSDateFormatter` object.

   @see `currentLocaleFormatter`
 */
+ (NSDateFormatter *)ys_currentLocaleFormatterOnlyDate;


/** Returns a date formatter object with a given date format and a specified time zone.

   @param formatString The date format for the receiver. eg. "yyyy'-'MM'-'dd' 'HH':'mm':'ss'".
   @param tzName The ID for the time zone. eg. "GMT", "Pacific/Honolulu", "Asia/Hong_Kong".

   @return A `NSDateFormatter` object.
 */
+ (NSDateFormatter *)ys_dateFormatterWithDateFormat:(NSString *)formatString timeZoneWithName:(NSString *)tzName;

/** Returns a date formatter object with Asia/Hong_Kong time zone.

   @return A cached `NSDateFormatter` object.

   @see `dateFormatterWithDateFormat:timeZoneWithName:`
 */
+ (NSDateFormatter *)ys_hongKongTimeZoneDateFormatter;

@end
