#import "NSNumber+YSKit.h"

@implementation NSNumber (YSKit)

+ (int)ys_randomInt:(int)maxInt {
	int r = arc4random() % maxInt;

	return r;
}

+ (BOOL)ys_randomBool {
	return [NSNumber ys_randomInt:2] != 0 ? YES : NO;
}

- (NSDate *)ys_dateValue {
	return [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];      // if self is nil, its doubleValue is 0.0
}

@end
