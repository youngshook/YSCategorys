
#import "YSKit.h"
#import "UIResponder+YSKit.h"

@implementation UIResponder (YSKit)

- (id)viewController {
    id nextResponder = self;
    do {
	if ([nextResponder isKindOfClass:[UIViewController class]]) {
	    return nextResponder;
	}
    } while ((nextResponder = [nextResponder nextResponder]));

    return nil;
}

@end
