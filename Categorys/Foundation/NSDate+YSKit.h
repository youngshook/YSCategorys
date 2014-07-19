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

- (NSUInteger)ys_daysAgo;
- (NSUInteger)ys_hoursAgo;
- (NSUInteger)ys_daysAgoAgainstMidnight;
- (NSString *)ys_stringDaysAgo;
- (NSString *)ys_stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger)ys_weekday;
- (NSTimeInterval)ys_unixTime;

+ (NSDate *)ys_dateFromString:(NSString *)string;
+ (NSDate *)ys_dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)ys_stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *)ys_stringFromDate:(NSDate *)date;
+ (NSString *)ys_stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)ys_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *)ys_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime;

- (NSString *)ys_string;
- (NSString *)ys_stringWithFormat:(NSString *)format;
- (NSString *)ys_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSDate *)ys_beginningOfWeek;
- (NSDate *)ys_beginningOfDay;
- (NSDate *)ys_endOfWeek;

+ (NSString *)ys_dateFormatString;
+ (NSString *)ys_timeFormatString;
+ (NSString *)ys_timestampFormatString;
+ (NSString *)ys_dbFormatString;

+ (NSDate *)ys_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)ys_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/** Returns a Boolean value that indicates whether the receiver and a given date object are the same day.

   @param date The date object to be compared to the receiver.

   @return `YES` if the receiver and anObject are the same day, otherwise `NO`.
 */
- (BOOL)ys_isSameDayWithDate:(NSDate *)date;

/** Returns the number of calendar days between two dates.

   @param fromDateTime The start date for the calculation.
   @param toDateTime The end date for the calculation.

   @return The number of calendar days between two dates.
 */
+ (NSInteger)ys_daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

- (NSDate *)ys_startTimeOfDate;
- (NSDate *)ys_endTimeOfDate;
@end
