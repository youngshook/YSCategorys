/*!
    UIWebView extension
	YSCategorys

	Copyright (c) 2013-2014 YoungShook
	https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIWebView (YSKit)

/**
 Getting the current document's title
 @returns A string with the document title
 */
- (NSString *)documentTitle;

/** Make the receiver’s background transparent.
 */
- (void)clearBackgroundImages;

@end
