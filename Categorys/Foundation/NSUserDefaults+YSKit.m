#import "NSUserDefaults+YSKit.h"

@implementation NSUserDefaults (YSKit)

+ (BOOL)ys_synchronize {
	return [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ys_setBool:(BOOL)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

+ (void)ys_setDouble:(double)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
}

+ (void)ys_setFloat:(float)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
}

+ (void)ys_setInteger:(NSInteger)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

+ (void)ys_setLong:(long)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLong:value] forKey:key];
}

+ (void)ys_setLongLong:(long long)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:value] forKey:key];
}

+ (void)ys_setNilValueForKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setNilValueForKey:key];
}

+ (void)ys_setObject:(id)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (void)ys_setURL:(NSURL *)url forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setURL:url forKey:key];
}

+ (BOOL)ys_boolForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (double)ys_doubleForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (float)ys_floatForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (NSInteger)ys_integerForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (long)ys_longForKey:(NSString *)key {
	return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longValue];
}

+ (long long)ys_longLongForKey:(NSString *)key {
	return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longLongValue];
}

+ (id)ys_objectForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (NSURL *)ys_URLForKey:(NSString *)key {
	return [[NSUserDefaults standardUserDefaults] URLForKey:key];
}

#pragma mark -

+ (void)ys_setCGRect:(CGRect)rect forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGRect(rect) forKey:key];
}

+ (void)ys_setCGSize:(CGSize)size forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGSize(size) forKey:key];
}

+ (void)ys_setCGPoint:(CGPoint)point forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(point) forKey:key];
}

+ (void)ys_setNSRange:(NSRange)range forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromRange(range) forKey:key];
}

+ (CGRect)ys_rectForKey:(NSString *)key {
	return CGRectFromString([self ys_objectForKey:key]);
}

+ (CGSize)ys_sizeForKey:(NSString *)key {
	return CGSizeFromString([NSUserDefaults ys_objectForKey:key]);
}

+ (CGPoint)ys_pointForKey:(NSString *)key {
	return CGPointFromString([NSUserDefaults ys_objectForKey:key]);
}

+ (NSRange)ys_rangeForKey:(NSString *)key {
	return NSRangeFromString([NSUserDefaults ys_objectForKey:key]);
}

@end
