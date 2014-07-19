#import "NSInvocation+YSKit.h"

@implementation NSInvocation (YSKit)

+ (NSInvocation *)ys_invocationWithTarget:(id)target andSelector:(SEL)selector {
	NSMethodSignature *sig = [[target class] instanceMethodSignatureForSelector:selector];
	NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
	[inv setTarget:target];
	[inv setSelector:selector];

	return inv;
}

+ (NSInvocation *)ys_invocationWithTarget:(id)target selector:(SEL)selector andArguments:(NSArray *)arguments {
	NSInvocation *inv = [NSInvocation ys_invocationWithTarget:target andSelector:selector];

	int argumentIndex = 2;
	for (int i = 0; i < arguments.count; i++) {
		id argument = [arguments objectAtIndex:i];
		[inv setArgument:&argument atIndex:argumentIndex];
		argumentIndex += 1;
	}
	[inv retainArguments];

	return inv;
}

@end
