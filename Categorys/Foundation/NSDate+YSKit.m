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
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:toDateTime];

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
	NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
	                                           fromDate:self
	                                             toDate:[NSDate date]
	                                            options:0];

	return [components day];
}

- (NSUInteger)ys_hoursAgo {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSHourCalendarUnit)
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
	NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];

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
	NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
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

			NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
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
	BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
	                       interval:NULL forDate:self];

	if (ok) {
		return beginningOfWeek;
	}

	// couldn't calc via range, so try to grab Sunday, assuming gregorian style
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];

	/*
	 *   Create a date components to represent the number of days to subtract from the current date.
	 *   The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
	 */
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];

	[componentsToSubtract setDay:0 - ([weekdayComponents weekday] - 1)];
	beginningOfWeek = nil;
	beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];

	// normalize to midnight, extract the year, month, and day components and create a new date from those components.
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
	                                           fromDate:beginningOfWeek];

	return [calendar dateFromComponents:components];
}

- (NSDate *)ys_beginningOfDay {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
	                                           fromDate:self];

	return [calendar dateFromComponents:components];
}

- (NSDate *)ys_endOfWeek {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
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

@end
