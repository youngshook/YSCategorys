/*!
    UIColor extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIColor (YSKit)

- (UIColor *)ys_initWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)ys_colorWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)ys_colorWithRGBHex:(NSInteger)hexValue;

+ (UIColor *)ys_colorWithRGBString:(NSString *)nsstring;
+ (UIColor *)ys_colorWithRGBString:(NSString *)nsstring alpha:(CGFloat)alpha;

+ (UIColor *)ys_colorWithPatternImageName:(NSString *)resourceName;

+ (UIColor *)ys_randColorWithAlpha:(CGFloat)alpha;
@end
