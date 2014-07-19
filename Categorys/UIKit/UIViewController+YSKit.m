#import "UIViewController+YSKit.h"

@implementation UIViewController (YSKit)

- (CGRect)ys_defaultViewFrame {
	CGRect frame        = [[UIScreen mainScreen] bounds];
	frame.size.height  -= [[UIApplication sharedApplication] isStatusBarHidden] ? 0.f : 20.f;
	frame.size.height  -= CGRectGetHeight([[[self tabBarController] tabBar] frame]);

	if ([self navigationController] && ![[self navigationController] isNavigationBarHidden])
		frame.size.height -= CGRectGetHeight([[[self navigationController] navigationBar] frame]);

	return frame;
}

+ (UIViewController *)ys_rootViewControllerWhichCanPresentModalViewController {
	UIViewController *vc = ([UIApplication sharedApplication].keyWindow.rootViewController) ? : [(UIWindow *)[[UIApplication sharedApplication].windows firstObject] rootViewController];

	while (vc.presentedViewController) {
		vc = vc.presentedViewController;
	}

	return vc;
}

- (void)ys_addChildViewController:(UIViewController *)childController intoView:(UIView *)viewControllerSubview {
	[self addChildViewController:childController];
	if (viewControllerSubview) {
		[viewControllerSubview addSubview:childController.view];
	}
	else {
		[self.view addSubview:childController.view];
	}

	[self didMoveToParentViewController:self];
}

- (void)ys_removeFromParentViewControllerAndView {
	[self willMoveToParentViewController:nil];

	if (self.view.superview) {
		[self.view removeFromSuperview];
	}

	if (self.parentViewController) {
		[self removeFromParentViewController];
	}
}

- (void)ys_dismissKeyboard {
	[[UIApplication sharedApplication].keyWindow endEditing:YES];

	//! ref: http://lldong.github.com/blog/2012/11/02/dissmiss-keyboard/
	//[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
