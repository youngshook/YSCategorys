#import "UIAlertView+YSKit.h"

@implementation UIAlertView (YSKit)

+ (void)ys_showWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
	if (buttonTitle == nil) {
		buttonTitle = @"OK";
	}
	[[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil] show];
}

@end
