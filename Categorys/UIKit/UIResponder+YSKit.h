/*!
    UIResponder extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIResponder (YSKit)

/** Traversing the responder chain to get a UIViewController reletive to the receiver.

   @return A view controller. `nil` if cannot find a UIViewController in responder chain.
 */
- (id)ys_viewController;

@end
