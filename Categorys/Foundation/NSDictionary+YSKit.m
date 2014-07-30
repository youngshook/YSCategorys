#import "NSDictionary+YSKit.h"

@implementation NSDictionary (YSKit)

- (BOOL)ys_boolForKey:(NSString *)keyName {
	return [[self objectForKey:keyName] boolValue];
}

- (float)ys_floatForKey:(NSString *)keyName {
	return [[self objectForKey:keyName] floatValue];
}

- (NSInteger)ys_integerForKey:(NSString *)keyName {
	return [[self objectForKey:keyName] integerValue];
}

- (double)ys_doubleForKey:(NSString *)keyName {
	return [[self objectForKey:keyName] doubleValue];
}

#pragma mark - JSON

- (NSString *)ys_JSONString {
	NSError *error = nil;

	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
	                                                   options:0
	                                                     error:&error];

	if (jsonData == nil) {
		NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);

		return nil;
	}

	NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

	return jsonString;
}

+ (NSDictionary *)ys_dictionaryWithJSON:(NSString *)json {
	NSError *error = nil;

	NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];

	NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:&error];

	if (jsonDict == nil) {
		NSLog(@"fail to get dictioanry from JSON: %@, error: %@", json, error);

		return nil;
	}

	return jsonDict;
}

+ (NSDictionary *)ys_dictionaryWithContentsOfURL:(NSURL *)URL error:(NSError **)error {
	NSData *readData = [NSData dataWithContentsOfURL:URL options:0 error:error];

	if (!readData) {
		return nil;
	}

	return [NSDictionary ys_dictionaryWithContentsOfData:readData error:error];
}

+ (NSDictionary *)ys_dictionaryWithContentsOfFile:(NSString *)path error:(NSError **)error {
	NSURL *url = [NSURL fileURLWithPath:path];
	return [NSDictionary ys_dictionaryWithContentsOfURL:url error:error];
}

+ (NSDictionary *)ys_dictionaryWithContentsOfData:(NSData *)data error:(NSError **)error {
	CFErrorRef parseError = NULL;
	NSDictionary *dictionary = (__bridge_transfer NSDictionary *)CFPropertyListCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)data, kCFPropertyListImmutable, NULL, (CFErrorRef *)&parseError);

	// we check if it is the correct type and only return it if it is
	if ([dictionary isKindOfClass:[NSDictionary class]]) {
		return dictionary;
	}
	else {
		if (parseError) {
			if (error) {
				*error = (__bridge NSError *)parseError;
			}

			CFRelease(parseError);
		}

		return nil;
	}
}

@end

@implementation NSMutableDictionary (YSKit)

- (NSUInteger)ys_addEntriesFromDictionary:(NSDictionary *)sourceDictionary withSpecifiedKeys:(NSString *)firstKey, ...{
	NSUInteger keyCopedCount = 0;
	va_list ap;
	va_start(ap, firstKey);
	for (NSString *key = firstKey; key != nil; key = va_arg(ap, id)) {
		id tmp = [sourceDictionary objectForKey:key];
		if (tmp) {
			[self setObject:tmp forKey:key];
			keyCopedCount++;
		}
	}
	va_end(ap);
	return keyCopedCount;
}

- (void)ys_setBool:(BOOL)value forKey:(NSString *)keyName {
	[self setObject:[NSNumber numberWithBool:value] forKey:keyName];
}

- (void)ys_setFloat:(float)value forKey:(NSString *)keyName {
	[self setObject:[NSNumber numberWithFloat:value] forKey:keyName];
}

- (void)ys_setInteger:(NSInteger)value forKey:(NSString *)keyName {
	[self setObject:[NSNumber numberWithInteger:value] forKey:keyName];
}

- (void)ys_setDouble:(double)value forKey:(NSString *)keyName {
	[self setObject:[NSNumber numberWithDouble:value] forKey:keyName];
}

@end
