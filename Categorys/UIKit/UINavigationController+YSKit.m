#import "UINavigationController+YSKit.h"

@implementation UINavigationController (YSKit)

- (Class)ys_previousViewControllerClassForViewController:(UIViewController *)viewController {
	NSUInteger idx = [self.viewControllers indexOfObject:viewController];
	if (idx == 0 || idx == NSNotFound) {
		return nil;
	}

	return [[self.viewControllers objectAtIndex:(idx - 1)] class];
}

- (id)ys_previousViewControllerForViewController:(UIViewController *)viewController {
	NSUInteger idx = [self.viewControllers indexOfObject:viewController];
	if (idx == 0 || idx == NSNotFound) return nil;

	return [self.viewControllers objectAtIndex:(idx - 1)];
}

- (BOOL)ys_hasViewControllerWithClass:(Class)aClass beforeViewController:(UIViewController *)viewController {
	NSUInteger idx = [self.viewControllers indexOfObject:viewController];
	if (idx == 0 || idx == NSNotFound) {
		return NO;
	}

	NSArray *vcs = self.viewControllers;
	for (NSInteger i = (idx - 1); i >= 0; i--) {
		if ([vcs[i] isKindOfClass:aClass]) {
			return YES;
		}
	}
	return NO;
}

- (NSArray *)ys_viewControllersForClass:(Class)aClass {
	NSMutableArray *controllers = [[NSMutableArray array] mutableCopy];

	for (UIViewController *v in self.viewControllers) {
		if ([v isKindOfClass:aClass] == YES) {
			[controllers addObject:v];
		}
	}

	NSArray *ary = [NSArray arrayWithArray:controllers];

	return ary;
}

- (UIViewController *)ys_viewControllerForClass:(Class)aClass {
	for (UIViewController *v in self.viewControllers) {
		if ([v isKindOfClass:aClass] == YES) {
			return v;
		}
	}

	return nil;
}

- (NSArray *)ys_popToViewControllerClass:(Class)aClass animated:(BOOL)animated {
	UIViewController *v = [self ys_viewControllerForClass:aClass];

	return [self popToViewController:v animated:animated];
}

- (UIViewController *)ys_popThenPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	UIViewController *v = [self popViewControllerAnimated:NO];

	[self pushViewController:viewController animated:animated];

	return v;
}

@end
