
#import "NSUserDefaults+YSKit.h"

@implementation NSUserDefaults (YSKit)

+ (BOOL)synchronize
{
	return [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

+ (void)setDouble:(double)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
}

+ (void)setFloat:(float)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

+ (void)setLong:(long)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLong:value] forKey:key];
}

+ (void)setLongLong:(long long)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:value] forKey:key];
}

+ (void)setNilValueForKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setNilValueForKey:key];
}

+ (void)setObject:(id)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setURL:url forKey:key];
}

+ (BOOL)boolForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (double)doubleForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (float)floatForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (NSInteger)integerForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (long)longForKey:(NSString *)key
{
	return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longValue];
}

+ (long long)longLongForKey:(NSString *)key
{
	return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longLongValue];
}

+ (id)objectForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (NSURL *)URLForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] URLForKey:key];
}

#pragma mark -

+ (void)setCGRect:(CGRect)rect forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGRect(rect) forKey:key];
}

+ (void)setCGSize:(CGSize)size forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGSize(size) forKey:key];
}

+ (void)setCGPoint:(CGPoint)point forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(point) forKey:key];
}

+ (void)setNSRange:(NSRange)range forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromRange(range) forKey:key];
}

+ (CGRect)rectForKey:(NSString *)key
{
	return CGRectFromString([self objectForKey:key]);
}

+ (CGSize)sizeForKey:(NSString *)key
{
	return CGSizeFromString([NSUserDefaults objectForKey:key]);
}

+ (CGPoint)pointForKey:(NSString *)key
{
	return CGPointFromString([NSUserDefaults objectForKey:key]);
}

+ (NSRange)rangeForKey:(NSString *)key
{
	return NSRangeFromString([NSUserDefaults objectForKey:key]);
}

@end
