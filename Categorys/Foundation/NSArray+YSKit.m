#import "NSArray+YSKit.h"

@implementation NSArray (YSKit)

- (id)ys_objectAtIndex:(NSUInteger)index {
	if (index >= self.count) {
		return nil;
	}

	return [self objectAtIndex:index];
}

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

+ (NSArray *)ys_arrayWithContentsOfURL:(NSURL *)URL error:(NSError **)error {
	NSData *readData = [NSData dataWithContentsOfURL:URL options:0 error:error];

	if (!readData) {
		return nil;
	}

	return [NSArray ys_arrayWithContentsOfData:readData error:error];
}

+ (NSArray *)ys_arrayWithContentsOfFile:(NSString *)path error:(NSError **)error {
	NSURL *url = [NSURL fileURLWithPath:path];
	return [NSArray ys_arrayWithContentsOfURL:url error:error];
}

+ (NSArray *)ys_arrayWithContentsOfData:(NSData *)data error:(NSError **)error {
	CFErrorRef parseError = NULL;
	NSArray *array = (__bridge_transfer NSArray *)CFPropertyListCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)data, kCFPropertyListImmutable, NULL, (CFErrorRef *)&parseError);

	if ([array isKindOfClass:[NSArray class]]) {
		return array;
	}

	if (parseError) {
		if (error) {
			*error = (__bridge NSError *)(parseError);
		}

		CFRelease(parseError);
	}

	return nil;
}

@end

@implementation NSMutableArray (YSKit)

- (void)ys_addObjectsFromDictionary:(NSDictionary *)sourceDictionary withSpecifiedKeys:(NSString *)firstKey, ...{
	va_list ap;
	va_start(ap, firstKey);
	for (NSString *key = firstKey; key != nil; key = va_arg(ap, id)) {
		id tmp = [sourceDictionary objectForKey:key];
		if (tmp) {
			[self addObject:tmp];
		}
	}
	va_end(ap);
}

@end
