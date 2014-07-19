/*!
    CGRect extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

//! via: https://gist.github.com/5797337.git

static __inline__ CGRect CGRectFromCGSize(CGSize size) {
	return CGRectMake(0, 0, size.width, size.height);
}

static __inline__ CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size) {
	return CGRectMake(center.x - size.width * 0.5, center.y - size.height * 0.5, size.width, size.height);
}

static __inline__ CGRect CGRectMakeWithOriginAndSize(CGPoint origin, CGSize size) {
	return CGRectMake(origin.x, origin.y, size.width, size.height);
}

static __inline__ CGPoint CGRectCenter(CGRect rect) {
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}
