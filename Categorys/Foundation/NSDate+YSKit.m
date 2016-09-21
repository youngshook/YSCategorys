#import "NSDate+YSKit.h"

@implementation NSDate (YSKit)

+ (NSDate *)ys_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	dc.year = year;
	dc.month = month;
	dc.day = day;
	dc.hour = hour;
	dc.minute = minute;
	dc.second = second;
	return [[NSCalendar currentCalendar] dateFromComponents:dc];
}

+ (NSDate *)ys_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
	return [NSDate ys_dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

- (BOOL)ys_isSameDayWithDate:(NSDate *)date {
	if (!date) return false;

	NSDateComponents *target = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
	NSDateComponents *source = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
	return [target isEqual:source];
}

//! ref: http://stackoverflow.com/a/4739650/945906
+ (NSInteger)ys_daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
	if (!fromDateTime && !toDateTime) return 0;
	NSParameterAssert(fromDateTime != nil);
	NSParameterAssert(toDateTime != nil);

	NSDate *fromDate;
	NSDate *toDate;

	NSCalendar *calendar = [NSCalendar currentCalendar];
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:fromDateTime];
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:toDateTime];

	NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
	return difference.day;
}

- (NSDate *)ys_startTimeOfDate {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)ys_endTimeOfDate {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
	components.hour = 24;
	components.minute = 0;
	components.second = 0;
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/*
 * This guy can be a little unreliable and produce unexpected results,
 * you're better off using daysAgoAgainstMidnight
 */
- (NSUInteger)ys_daysAgo {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
	                                           fromDate:self
	                                             toDate:[NSDate date]
	                                            options:0];

	return [components day];
}

- (NSUInteger)ys_hoursAgo {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitHour)
	                                           fromDate:self
	                                             toDate:[NSDate date]
	                                            options:0];

	return [components hour];
}

- (NSUInteger)ys_daysAgoAgainstMidnight {
	// get a midnight version of ourself:
	NSDateFormatter *mdf = [[NSDateFormatter alloc] init];

	[mdf setDateFormat:@"yyyy-MM-dd"];

	NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];

	return (int)[midnight timeIntervalSinceNow] / (secondsIn1Day) * -1;
}

- (NSString *)ys_stringDaysAgo {
	return [self ys_stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)ys_stringDaysAgoAgainstMidnight:(BOOL)flag {
	NSUInteger daysAgo = (flag) ? [self ys_daysAgoAgainstMidnight] : [self ys_daysAgo];
	NSString *text = nil;

	switch (daysAgo) {
		case 0:
			text = @"Today";
			break;

		case 1:
			text = @"Yesterday";
			break;

		default:
			text = [NSString stringWithFormat:@"%lu days ago", (unsigned long)daysAgo];
	}

	return text;
}

- (NSUInteger)ys_weekday {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];

	return [weekdayComponents weekday];
}

- (NSTimeInterval)ys_unixTime {
	return [self timeIntervalSince1970];     // if nil, return 0.0
}

+ (NSDate *)ys_dateFromString:(NSString *)string {
	return [NSDate ys_dateFromString:string withFormat:[NSDate ys_dbFormatString]];
}

+ (NSDate *)ys_dateFromString:(NSString *)string withFormat:(NSString *)format {
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];

	[inputFormatter setDateFormat:format];

	NSDate *date = [inputFormatter dateFromString:string];

	return date;
}

+ (NSString *)ys_stringFromDate:(NSDate *)date withFormat:(NSString *)format {
	return [date ys_stringWithFormat:format];
}

+ (NSString *)ys_stringFromDate:(NSDate *)date {
	return [date ys_string];
}

+ (NSString *)ys_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime {
	/*
	 * if the date is in today, display 12-hour time with meridian,
	 * if it is within the last 7 days, display weekday name (Friday)
	 * if within the calendar year, display as Jan 23
	 * else display as Nov 11, 2008
	 */
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];

	NSDate *today = [NSDate date];
	NSDateComponents *offsetComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
	                                                 fromDate:today];

	NSDate *midnight = [calendar dateFromComponents:offsetComponents];
	NSString *displayString = nil;

	// comparing against midnight
	NSComparisonResult midnight_result = [date compare:midnight];

	if (midnight_result == NSOrderedDescending) {
		if (prefixed) {
			[displayFormatter setDateFormat:@"'at' h:mm a"];             // at 11:30 am
		}
		else {
			[displayFormatter setDateFormat:@"h:mm a"];             // 11:30 am
		}
	}
	else {
		// check if date is within last 7 days
		NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];

		[componentsToSubtract setDay:-7];

		NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];

		NSComparisonResult lastweek_result = [date compare:lastweek];

		if (lastweek_result == NSOrderedDescending) {
			if (displayTime) {
				[displayFormatter setDateFormat:@"EEEE h:mm a"];
			}
			else {
				[displayFormatter setDateFormat:@"EEEE"];                 // Tuesday
			}
		}
		else {
			// check if same calendar year
			NSInteger thisYear = [offsetComponents year];

			NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
			                                               fromDate:date];
			NSInteger thatYear = [dateComponents year];

			if (thatYear >= thisYear) {
				if (displayTime) {
					[displayFormatter setDateFormat:@"MMM d h:mm a"];
				}
				else {
					[displayFormatter setDateFormat:@"MMM d"];
				}
			}
			else {
				if (displayTime) {
					[displayFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
				}
				else {
					[displayFormatter setDateFormat:@"MMM d, yyyy"];
				}
			}
		}

		if (prefixed) {
			NSString *dateFormat = [displayFormatter dateFormat];
			NSString *prefix = @"'on' ";

			[displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
		}
	}

	// use display formatter to return formatted date string
	displayString = [displayFormatter stringFromDate:date];

	return displayString;
}

+ (NSString *)ys_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
	return [[self class] ys_stringForDisplayFromDate:date prefixed:prefixed alwaysDisplayTime:NO];
}

+ (NSString *)ys_stringForDisplayFromDate:(NSDate *)date {
	return [self ys_stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)ys_stringWithFormat:(NSString *)format {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];

	[outputFormatter setDateFormat:format];

	NSString *timestamp_str = [outputFormatter stringFromDate:self];

	return timestamp_str;
}

- (NSString *)ys_string {
	return [self ys_stringWithFormat:[NSDate ys_dbFormatString]];
}

- (NSString *)ys_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];

	[outputFormatter setDateStyle:dateStyle];
	[outputFormatter setTimeStyle:timeStyle];

	NSString *outputString = [outputFormatter stringFromDate:self];

	return outputString;
}

- (NSDate *)ys_beginningOfWeek {
	// largely borrowed from "Date and Time Programming Guide for Cocoa"
	// we'll use the default calendar and hope for the best
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDate *beginningOfWeek = nil;
	BOOL ok = [calendar rangeOfUnit:NSCalendarUnitWeekday startDate:&beginningOfWeek
	                       interval:NULL forDate:self];

	if (ok) {
		return beginningOfWeek;
	}

	// couldn't calc via range, so try to grab Sunday, assuming gregorian style
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];

	/*
	 *   Create a date components to represent the number of days to subtract from the current date.
	 *   The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
	 */
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];

	[componentsToSubtract setDay:0 - ([weekdayComponents weekday] - 1)];
	beginningOfWeek = nil;
	beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];

	// normalize to midnight, extract the year, month, and day components and create a new date from those components.
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
	                                           fromDate:beginningOfWeek];

	return [calendar dateFromComponents:components];
}

- (NSDate *)ys_beginningOfDay {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
	                                           fromDate:self];

	return [calendar dateFromComponents:components];
}

- (NSDate *)ys_endOfWeek {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];

	// to get the end of week for a particular date, add (7 - weekday) days
	[componentsToAdd setDay:(7 - [weekdayComponents weekday])];

	NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];

	return endOfWeek;
}

+ (NSString *)ys_dateFormatString {
	return @"yyyy-MM-dd";
}

+ (NSString *)ys_timeFormatString {
	return @"HH:mm:ss";
}

+ (NSString *)ys_timestampFormatString {
	return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)ys_dbFormatString {
	return [NSDate ys_timestampFormatString];
}


/*******
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ********/
- (NSDateComponents *)ys_date_componentsOfDay
{
    static NSDateComponents *dateComponents = nil;
    static NSDate *previousDate = nil;
    
    if (!previousDate || ![previousDate isEqualToDate:self]) {
        previousDate = self;
        dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    }
    
    return dateComponents;
}


//  --------------------------NSDate---------------------------
- (NSInteger)ys_date_weekdayOrdinal
{
    return self.ys_date_weekdayOrdinal;
}


/*
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 */
- (NSUInteger)ys_date_year
{
    return [self ys_date_componentsOfDay].year;
}

/*
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 */
- (NSUInteger)ys_date_month
{
    return [self ys_date_componentsOfDay].month;
}


/*
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 */
- (NSUInteger)ys_date_day
{
    return [self ys_date_componentsOfDay].day;
}


/*
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 */
- (NSUInteger)ys_date_hour
{
    return [self ys_date_componentsOfDay].hour;
}


/*
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 */
- (NSUInteger)ys_date_minute
{
    return [self ys_date_componentsOfDay].minute;
}


/*
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 */
- (NSUInteger)ys_date_second
{
    return [self ys_date_componentsOfDay].second;
}

/*
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 */
- (NSUInteger)ys_date_weekday
{
    return [self ys_date_componentsOfDay].weekday;
}

/*
 *@Description:获得NSDate对应的周数
 *@Params:nil
 *@Return:NSDate对应的周数
 */
- (NSUInteger)ys_date_week
{
    return [self ys_date_componentsOfDay].weekOfMonth;
}

/*
 *@Description:获取当天的起始时间（00:00:00）
 *@Params:nil
 *@Return:当天的起始时间
 */
- (NSDate *)ys_date_beginingOfDay
{
    [[self ys_date_componentsOfDay] setHour:0];
    [[self ys_date_componentsOfDay] setMinute:0];
    [[self ys_date_componentsOfDay] setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self ys_date_componentsOfDay]];
}

/*
 *@Description:获取当天的结束时间（23:59:59）
 *@Params:nil
 *@Return:当天的结束时间
 */
- (NSDate *)ys_date_endOfDay
{
    [[self ys_date_componentsOfDay] setHour:23];
    [[self ys_date_componentsOfDay] setMinute:59];
    [[self ys_date_componentsOfDay] setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self ys_date_componentsOfDay]];
}

/*
 *@Description:获取当月的第一天
 *@Params:nil
 *@Return:当月的第一天
 */
- (NSDate *)ys_date_firstDayOfTheMonth
{
    [[self ys_date_componentsOfDay] setDay:1];
    return [[NSCalendar currentCalendar] dateFromComponents:[self ys_date_componentsOfDay]];
}

/*
 *@Description:获取当月的最后一天
 *@Params:nil
 *@Return:当月的最后一天
 */
- (NSDate *)ys_date_lastDayOfTheMonth
{
    [[self ys_date_componentsOfDay] setDay:[self ys_date_numberOfDaysInMonth]];
    return [[NSCalendar currentCalendar] dateFromComponents:[self ys_date_componentsOfDay]];
}

/*
 *@Description:获取前一个月的第一天
 *@Params:nil
 *@Return:前一个月的第一天
 */
- (NSDate *)ys_date_firstDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] ys_date_firstDayOfTheMonth];
}

/*
 *@Description:获取后一个月的第一天
 *@Params:nil
 *@Return:后一个月的第一天
 */
- (NSDate *)ys_date_firstDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] ys_date_firstDayOfTheMonth];
}


/*
 *@Description:获取前一个月中与当天对应的日期
 *@Params:nil
 *@Return:前一个月中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/*
 *@Description:获取后一个月中与当天对应的日期
 *@Params:nil
 *@Return:后一个月中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}


/*
 *@Description:获取当月的天数
 *@Params:nil
 *@Return:当月的天数
 */
- (NSUInteger)ys_date_numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}


/*
 *@Description:获取当月的周数
 *@Params:nil
 *@Return:当月的周数
 */
- (NSUInteger)ys_date_numberOfWeeksInMonth
{
    NSUInteger weekOfFirstDay = [[self ys_date_firstDayOfTheMonth] ys_date_componentsOfDay].weekday;
    NSUInteger numberDaysInMonth = [self ys_date_numberOfDaysInMonth];
    
    return ((weekOfFirstDay - 1 + numberDaysInMonth) % 7) ? ((weekOfFirstDay - 1 + numberDaysInMonth) / 7 + 1): ((weekOfFirstDay - 1 + numberDaysInMonth) / 7);
}


/*
 *@Description:获取这一周的第一天
 *@Params:nil
 *@Return:这一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheWeek
{
    NSDate *firstDay = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDay interval:NULL forDate:self]) {
        return firstDay;
    }
    
    return firstDay;
}

/*
 *@Description:获取当月中，前一周的第一天
 *@Params:nil
 *@Return:前一周的第一天
 */
- (NSDate *)ys_date_firstDayOfThePreviousWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self ys_date_firstDayOfTheWeekInTheMonth];
    if ([firstDayOfTheWeekInTheMonth ys_date_componentsOfDay].weekday > 1) {
        return nil;
    } else {
        if ([firstDayOfTheWeekInTheMonth ys_date_componentsOfDay].day > 7) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.day = -7;
            return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
        } else if ([firstDayOfTheWeekInTheMonth ys_date_componentsOfDay].day > 1) {
            return [self ys_date_firstDayOfTheMonth];
        } else {
            return nil;
        }
    }
}

/*
 *@Description:获取前一个月中，最后一周的第一天
 *@Params:nil
 *@Return:前一个月中，最后一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheLastWeekInPreviousMonth
{
    NSDate *firstDayOfThePreviousMonth = [self ys_date_firstDayOfThePreviousMonth];
    NSUInteger numberOfDaysInPreviousMonth = [firstDayOfThePreviousMonth ys_date_numberOfDaysInMonth];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = [firstDayOfThePreviousMonth ys_date_componentsOfDay].year;
    components.month = [firstDayOfThePreviousMonth ys_date_componentsOfDay].month;
    components.day = numberOfDaysInPreviousMonth;
    NSDate *lastDayOfThePreviousMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return [lastDayOfThePreviousMonth ys_date_firstDayOfTheWeekInTheMonth];
}


/*
 *@Description:获取当月中，后一周的第一天
 *@Params:nil
 *@Return:后一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheFollowingWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self ys_date_firstDayOfTheWeekInTheMonth];
    NSUInteger numberOfDaysInMonth = [self ys_date_numberOfDaysInMonth];
    if (([firstDayOfTheWeekInTheMonth ys_date_componentsOfDay].day + 6) >= numberOfDaysInMonth) {
        return nil;
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 6;
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    }
}

/*
 *@Description:获取下一个月中，最前一周的第一天
 *@Params:nil
 *@Return:下一个月中，最前一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheFirstWeekInFollowingMonth
{
    NSDate *firstDayOfTheFollowingMonth = [self ys_date_firstDayOfTheFollowingMonth];
    
    return [firstDayOfTheFollowingMonth ys_date_firstDayOfTheWeekInTheMonth];
}


/*
 *@Description:获取当月中，这一周的第一天
 *@Params:nil
 *@Return:当月中，这一周的第一天
 */
- (NSDate *)ys_date_firstDayOfTheWeekInTheMonth
{
    NSDate *firstDayOfTheWeek = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDayOfTheWeek interval:NULL forDate:self]) {
        NSDate *firstDayOfTheMonth = [self ys_date_firstDayOfTheMonth];
        if ([firstDayOfTheWeek ys_date_componentsOfDay].month == [firstDayOfTheMonth ys_date_componentsOfDay].month) {
            return firstDayOfTheWeek;
        } else {
            return firstDayOfTheMonth;
        }
    }
    
    return firstDayOfTheWeek;
}


/*
 *@Description:获取当月中，这一周的天数
 *@Params:nil
 *@Return:当月中，这一周的天数
 */
- (NSUInteger)ys_date_numberOfDaysInTheWeekInMonth
{
    NSDate *firstDayOfTheWeek = [self ys_date_firstDayOfTheWeek];
    NSDate *firstDayOfTheWeekInTheMonth = [self ys_date_firstDayOfTheWeekInTheMonth];
    
    if ([firstDayOfTheWeek ys_date_componentsOfDay].month == [firstDayOfTheWeekInTheMonth ys_date_componentsOfDay].month) {
        return (firstDayOfTheWeek.ys_date_numberOfDaysInMonth - [firstDayOfTheWeek ys_date_componentsOfDay].day + 1) >= 7 ? 7 : (firstDayOfTheWeek.ys_date_numberOfDaysInMonth - [firstDayOfTheWeek ys_date_componentsOfDay].day + 1);
    } else {
        return (8 - [firstDayOfTheWeekInTheMonth ys_date_componentsOfDay].weekday);
    }
}

/*
 *@Description:获取当天是当月的第几周
 *@Params:nil
 *@Return:当天是当月的第几周
 */
- (NSUInteger)ys_date_weekOfDayInMonth
{
    NSDate *firstDayOfTheMonth = [self ys_date_firstDayOfTheMonth];
    NSUInteger weekdayOfFirstDayOfTheMonth = [firstDayOfTheMonth ys_date_componentsOfDay].weekday;
    NSUInteger day = [self ys_date_componentsOfDay].day;
    
    return ((day + weekdayOfFirstDayOfTheMonth - 1)%7) ? ((day + weekdayOfFirstDayOfTheMonth - 1)/7) + 1: ((day + weekdayOfFirstDayOfTheMonth - 1)/7);
}

/*
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 */
- (NSUInteger)ys_date_weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

/*
 *@Description:获取前一周中与当天对应的日期
 *@Params:nil
 *@Return:前一个周中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfThePreviousWeek
{
    NSUInteger day = [self ys_date_componentsOfDay].day;
    NSUInteger weekday = [self ys_date_componentsOfDay].weekday;
    
    if (day > 7) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -7;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if (day > weekday) {
        
        return [self ys_date_firstDayOfTheMonth];
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -1;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[self ys_date_firstDayOfTheWeekInTheMonth] options:0];
    }
}

/*
 *@Description:获取后一周中与当天对应的日期
 *@Params:nil
 *@Return:后一周中与当天对应的日期
 */
- (NSDate *)ys_date_associateDayOfTheFollowingWeek
{
    NSUInteger numberOfDaysInMonth = [self ys_date_numberOfDaysInMonth];
    NSUInteger day = [self ys_date_componentsOfDay].day;
    NSUInteger weekday = [self ys_date_componentsOfDay].weekday;
    if (day + 7 <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 7;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if ((day + (7 - weekday + 1)) <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = numberOfDaysInMonth - day;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else {
        return [self ys_date_firstDayOfTheFollowingMonth];
    }
}


/*
 *@Description:前一天
 *@Params:nil
 *@Return:前一天
 */
- (NSDate *)ys_date_previousDay
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)ys_date_dateWithDayInterval:(NSInteger)dayInterval {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = dayInterval;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/*
 *@Description:后一天
 *@Params:nil
 *@Return:后一天
 */
- (NSDate *)ys_date_followingDay
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}


/*
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 */
- (BOOL)ys_date_sameDayWithDate:(NSDate *)otherDate
{
    if (self.ys_date_year == otherDate.ys_date_year && self.ys_date_month == otherDate.ys_date_month && self.ys_date_day == otherDate.ys_date_day) {
        return YES;
    } else {
        return NO;
    }
}


/*
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 */
- (BOOL)ys_date_sameWeekWithDate:(NSDate *)otherDate
{
    if (self.ys_date_year == otherDate.ys_date_year  && self.ys_date_month == otherDate.ys_date_month && self.ys_date_weekOfDayInYear == otherDate.ys_date_weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

/*
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 */
- (BOOL)ys_date_sameMonthWithDate:(NSDate *)otherDate
{
    if (self.ys_date_year == otherDate.ys_date_year && self.ys_date_month == otherDate.ys_date_month) {
        return YES;
    } else {
        return NO;
    }
}

@end
