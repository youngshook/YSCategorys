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

/*
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 */
- (NSDateComponents *)ys_date_componentsOfDay;


- (NSInteger)ys_date_weekdayOrdinal;

/*
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 */
- (NSUInteger)ys_date_year;

/*
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 */
- (NSUInteger)ys_date_month;


/*
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 */
- (NSUInteger)ys_date_day;


/*
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 */
- (NSUInteger)ys_date_hour;


/*
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 */
- (NSUInteger)ys_date_minute;


/*
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 */
- (NSUInteger)ys_date_second;

/*
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 */
- (NSUInteger)ys_date_weekday;

/*
 *@Description:获得NSDate对应的周数
 *@Params:nil
 *@Return:NSDate对应的周数
 */
- (NSUInteger)ys_date_week;

/*
 *@Description:获取当天的起始时间（00:00:00）
 *@Params:nil
 *@Return:当天的起始时间
 */
- (NSDate *)ys_date_beginingOfDay;

/*
 *@Description:获取当天的结束时间（23:59:59）
 *@Params:nil
 *@Return:当天的结束时间
 */
- (NSDate *)ys_date_endOfDay;


/*
 *@Description:获取当月的第一天
 *@Params:nil
 *@Return:当月的第一天
 */
- (NSDate *)ys_date_firstDayOfTheMonth;

/*
 *@Description:获取当月的最后一天
 *@Params:nil
 *@Return:当月的最后一天
 */
- (NSDate *)ys_date_lastDayOfTheMonth;


/*
 *@Description:获取前一个月的第一天
 *@Params:nil
 *@Return:前一个月的第一天
 */
- (NSDate *)ys_date_firstDayOfThePreviousMonth;

/*
 *@Description:获取后一个月的第一天
 *@Params:nil
 *@Return:后一个月的第一天
 */
- (NSDate *)ys_date_firstDayOfTheFollowingMonth;

/*
 *@Description:获取前一个月中与当天对应的日期
 *@Params:nil
 *@Return:前一个月中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfThePreviousMonth;

/*
 *@Description:获取后一个月中与当天对应的日期
 *@Params:nil
 *@Return:后一个月中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfTheFollowingMonth;


/*
 *@Description:获取当月的天数
 *@Params:nil
 *@Return:当月的天数
 */
- (NSUInteger)ys_date_numberOfDaysInMonth;

/*
 *@Description:获取当月的周数
 *@Params:nil
 *@Return:当月的周数
 */
- (NSUInteger)ys_date_numberOfWeeksInMonth;


/*
 *@Description:获取这一周的第一天
 *@Params:nil
 *@Return:这一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheWeek;

/*
 *@Description:获取当月中，前一周的第一天
 *@Params:nil
 *@Return:前一周的第一天
 */
- (NSDate *)ys_date_firstDayOfThePreviousWeekInTheMonth;

/*
 *@Description:获取前一个月中，最后一周的第一天
 *@Params:nil
 *@Return:前一个月中，最后一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheLastWeekInPreviousMonth;

/*
 *@Description:获取当月中，后一周的第一天
 *@Params:nil
 *@Return:后一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheFollowingWeekInTheMonth;

/*
 *@Description:获取下一个月中，最前一周的第一天
 *@Params:nil
 *@Return:下一个月中，最前一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheFirstWeekInFollowingMonth;


/*
 *@Description:获取当月中，这一周的第一天
 *@Params:nil
 *@Return:当月中，这一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheWeekInTheMonth;

/*
 *@Description:获取当月中，这一周的天数
 *@Params:nil
 *@Return:当月中，这一周的天数
 */
- (NSUInteger)ys_date_numberOfDaysInTheWeekInMonth;


/*
 *@Description:获取当天是当月的第几周
 *@Params:nil
 *@Return:当天是当月的第几周
 */
- (NSUInteger)ys_date_weekOfDayInMonth;

/*
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 */
- (NSUInteger)ys_date_weekOfDayInYear;


/*
 *@Description:获取前一周中与当天对应的日期
 *@Params:nil
 *@Return:前一个周中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfThePreviousWeek;

/*
 *@Description:获取后一周中与当天对应的日期
 *@Params:nil
 *@Return:后一周中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfTheFollowingWeek;



/*
 *@Description:前一天
 *@Params:nil
 *@Return:前一天
 */
- (NSDate *)ys_date_previousDay;

/*!
 *  @brief  相差几天
 *
 *  @param dayInterval 差值 可以负数
 *
 *  @return date
 */
- (NSDate *)ys_date_dateWithDayInterval:(NSInteger)dayInterval;

/*
 *@Description:后一天
 *@Params:nil
 *@Return:后一天
 */
- (NSDate *)ys_date_followingDay;

/*
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 */
- (BOOL)ys_date_sameDayWithDate:(NSDate *)otherDate;

/*
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 */
- (BOOL)ys_date_sameWeekWithDate:(NSDate *)otherDate;

/*
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 */
- (BOOL)ys_date_sameMonthWithDate:(NSDate *)otherDate;

@end
