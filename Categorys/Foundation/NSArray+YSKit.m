
#import "YSKit.h"
#import "NSArray+YSKit.h"

@implementation NSArray (YSKit)

- (id)ys_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
	return nil;
    }

    return [self objectAtIndex:index];
}

@end

@implementation NSMutableArray (YSKit)

- (void)addObjectsFromDictionary:(NSDictionary *)sourceDictionary withSpecifiedKeys:(NSString *)firstKey, ... {
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
