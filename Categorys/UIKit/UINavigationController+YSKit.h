/*!
    UINavigationController extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>

@interface UINavigationController (YSKit)

/** Get the previous view controller’s class of the specified view controller in the navigation stack.

   @return Returns the previous view controller’s class of the specified view controller.
 */
- (Class)ys_previousViewControllerClassForViewController:(UIViewController *)viewController;


/** Get the previous view controller of the specified view controller in the navigation stack.

   @return Returns the previous view controller of the specified view controller.
 */
- (id)ys_previousViewControllerForViewController:(UIViewController *)viewController;

/** Return whether there is a given kind of view controller in the navigation stack before a view controller.

   @return Returns `YES` if there are any view controllers which is kind of given class before the specified view controller; otherwise, `NO`.
 */
- (BOOL)ys_hasViewControllerWithClass:(Class)aClass beforeViewController:(UIViewController *)viewController;

/**
 *  seek all the object is kind of aClass
 */
- (NSArray *)ys_viewControllersForClass:(Class)aClass;

/**
 * seek the first one object is kind of aClass and return it
 */
- (UIViewController *)ys_viewControllerForClass:(Class)aClass;

/**
 * pop to the first object is kind of aClass and return poped viewControllers
 */
- (NSArray *)ys_popToViewControllerClass:(Class)aClass animated:(BOOL)animated;

/*
 * pop and then push
 *
 * http://stackoverflow.com/questions/410471/how-can-i-pop-a-view-from-a-uinavigationcontroller-and-replace-it-with-another-i
 */
- (UIViewController *)ys_popThenPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
