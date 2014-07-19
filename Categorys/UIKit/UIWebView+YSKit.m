#import "UIWebView+YSKit.h"

@implementation UIWebView (YSKit)

- (void)ys_clearBackgroundImages {
	self.opaque = NO;
	for (UIView *view in[[self.subviews firstObject] subviews]) {
		if ([view isKindOfClass:[UIImageView class]]) {
			view.hidden = YES;
		}
	}
}

- (NSString *)ys_documentTitle {
	return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
