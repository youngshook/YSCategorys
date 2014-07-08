/*!
    NSDate extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

#define secondsIn1Day 86400

@interface NSDate (YSKit)

- (NSUInteger) daysAgo;
- (NSUInteger) hoursAgo;
- (NSUInteger) daysAgoAgainstMidnight;
- (NSString *) stringDaysAgo;
- (NSString *) stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger) weekday;
- (NSTimeInterval) unixTime;

+ (NSDate *) dateFromString:(NSString *)string;
+ (NSDate *) dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *) stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *) stringFromDate:(NSDate *)date;
+ (NSString *) stringForDisplayFromDate:(NSDate *)date;
+ (NSString *) stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *) stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime;

- (NSString *) string;
- (NSString *) stringWithFormat:(NSString *)format;
- (NSString *) stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSDate *) beginningOfWeek;
- (NSDate *) beginningOfDay;
- (NSDate *) endOfWeek;

+ (NSString *) dateFormatString;
+ (NSString *) timeFormatString;
+ (NSString *) timestampFormatString;
+ (NSString *) dbFormatString;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/** Returns a Boolean value that indicates whether the receiver and a given date object are the same day.

 @param date The date object to be compared to the receiver.

 @return `YES` if the receiver and anObject are the same day, otherwise `NO`.
 */
- (BOOL)isSameDayWithDate:(NSDate *)date;

/** Returns the number of calendar days between two dates.

 @param fromDateTime The start date for the calculation.
 @param toDateTime The end date for the calculation.

 @return The number of calendar days between two dates.
 */
+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

- (NSDate *)startTimeOfDate;
- (NSDate *)endTimeOfDate;
@end
