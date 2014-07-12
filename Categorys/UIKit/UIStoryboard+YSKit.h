/*!
    UIStoryboard extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIStoryboard (YSKit)

// By using this method, you must set view controller stroryboard ID to it's class name.
- (id)ys_instantiateViewControllerWithIdentifierUsingClass:(Class)viewControllerClass;
@end
