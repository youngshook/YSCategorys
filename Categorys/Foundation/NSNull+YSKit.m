//! via: https://gist.github.com/cyndibaby905/9828745

#import "NSNull+YSKit.h"

#define NSNullObjects @[@"", @0, @{}, @[]]

@implementation NSNull (YSKit)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	NSMethodSignature *signature = [super methodSignatureForSelector:selector];
	if (!signature) {
		for (NSObject *object in NSNullObjects) {
			signature = [object methodSignatureForSelector:selector];
			if (signature) {
				break;
			}
		}
	}
	return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	SEL aSelector = [anInvocation selector];

	for (NSObject *object in NSNullObjects) {
		if ([object respondsToSelector:aSelector]) {
			[anInvocation invokeWithTarget:object];
			return;
		}
	}

	[self doesNotRecognizeSelector:aSelector];
}

@end
