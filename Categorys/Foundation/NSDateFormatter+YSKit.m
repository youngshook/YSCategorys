#import "NSDateFormatter+YSKit.h"

@implementation NSDateFormatter (YSKit)
+ (NSDateFormatter *)ys_GMTFormatter {
	static NSDateFormatter *share;
	if (!share) {
		share = [[NSDateFormatter alloc] init];
		[share setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
		[share setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	}
	return [share copy];
}

+ (NSDateFormatter *)ys_currentLocaleFormatter {
	static NSDateFormatter *share;
	if (!share) {
		share = [[NSDateFormatter alloc] init];
		[share setLocale:[NSLocale currentLocale]];
		[share setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];
	}
	return [share copy];
}

+ (NSDateFormatter *)ys_currentLocaleFormatterOnlyDate {
	static NSDateFormatter *share;
	if (!share) {
		share = [[NSDateFormatter alloc] init];
		[share setLocale:[NSLocale currentLocale]];
		[share setDateFormat:@"yyyy'-'MM'-'dd"];
	}
	return [share copy];
}

+ (NSDateFormatter *)ys_dateFormatterWithDateFormat:(NSString *)formatString timeZoneWithName:(NSString *)tzName {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone timeZoneWithName:tzName]];
	[formatter setDateFormat:formatString];
	return formatter;
}

+ (NSDateFormatter *)ys_hongKongTimeZoneDateFormatter {
	static NSDateFormatter *share;
	if (!share) {
		share = [NSDateFormatter ys_dateFormatterWithDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss" timeZoneWithName:@"Asia/Hong_Kong"];
	}
	return [share copy];
}

@end
