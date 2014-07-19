#import "UIResponder+YSKit.h"

@implementation UIResponder (YSKit)

- (id)ys_viewController {
	id nextResponder = self;
	do {
		if ([nextResponder isKindOfClass:[UIViewController class]]) {
			return nextResponder;
		}
	}
	while ((nextResponder = [nextResponder nextResponder]));

	return nil;
}

@end
