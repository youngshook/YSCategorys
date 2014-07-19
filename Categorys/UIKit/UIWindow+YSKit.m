#import "UIWindow+YSKit.h"

@implementation UIWindow (YSKit)

+ (UIWindow *)ys_mainWindow {
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];

	if (window && ![window isKindOfClass:[NSClassFromString(@"_UIAlertNormalizingOverlayWindow") class]])
		return window;

	NSArray *windows = [[UIApplication sharedApplication] windows];

	return [windows count] ? windows[0] : nil;
}

+ (UIView *)ys_keyboardView {
	for (UIWindow *window in[[UIApplication sharedApplication] windows])
		for (UIView * view in[window subviews])
			if ([view isKindOfClass:NSClassFromString(@"UIPeripheralHostView")])
				return view;

	return nil;
}

@end
