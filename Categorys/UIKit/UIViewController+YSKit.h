/*!
    UIViewController extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIViewController (YSKit)

- (CGRect)ys_defaultViewFrame;

/** Return a view which can present another view controller.

   @discussion First we get an window´s root view controller. Then  traverse its presentedViewController property until the presentedViewController property is nil.

   @return A view controller which can present another view controller.
 */
+ (UIViewController *)ys_rootViewControllerWhichCanPresentModalViewController;

/** Adds the given view controller as a child and add its view to specified view as a subview.

   @discussion Using this method, you dont need to call  `didMoveToParentViewController` manually.

   @param childController The view controller to be added as a child.
   @param viewControllerSubview Which view should childController´s view be added.
 */
- (void)ys_addChildViewController:(UIViewController *)childController intoView:(UIView *)viewControllerSubview;

/** Removes the receiver and its view from its parent view controller and the view´s superview.

   @discussion Using this method, you dont need to call  `willMoveToParentViewController` manually.
 */
- (void)ys_removeFromParentViewControllerAndView;

/** Dismiss keyboard by resign the first responder status.

   @discussion You can use this method to dismiss keyboard even the first responder not belong to the reciver.
 */
- (void)ys_dismissKeyboard;

@end
