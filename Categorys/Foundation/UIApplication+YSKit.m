#import "UIApplication+YSKit.h"

static NSInteger YSNetworkActivityCounter_ = 0;

@implementation UIApplication (YSKit)

- (CGFloat)ys_applicationVersion {
	return [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] floatValue];
}

- (void)ys_increaseNetworkActivityCounter {
	YSNetworkActivityCounter_++;

	if (YSNetworkActivityCounter_ == 1)
		[self setNetworkActivityIndicatorVisible:YES];
}

- (void)ys_decreaseNetworkActivityCounter {
	YSNetworkActivityCounter_--;

	if (YSNetworkActivityCounter_ < 0)
		YSNetworkActivityCounter_ = 0;

	if (YSNetworkActivityCounter_ == 0)
		[self setNetworkActivityIndicatorVisible:NO];
}

@end
