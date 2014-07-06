
#import "YSKit.h"
#import "UIWebView+YSKit.h"

@implementation UIWebView (YSKit)

- (void)clearBackgroundImages {
    self.opaque = NO;
    for (UIView *view in [[self.subviews firstObject] subviews]) {
	if ([view isKindOfClass:[UIImageView class]]) {
	    view.hidden = YES;
	}
    }
}

@end
