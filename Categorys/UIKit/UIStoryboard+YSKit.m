#import "UIStoryboard+YSKit.h"

@implementation UIStoryboard (YSKit)

- (id)ys_instantiateViewControllerWithIdentifierUsingClass:(Class)viewControllerClass {
	return [self instantiateViewControllerWithIdentifier:NSStringFromClass(viewControllerClass)];
}

@end
