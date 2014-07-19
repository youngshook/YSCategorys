#import "UIColor+YSKit.h"

@implementation UIColor (YSKit)

#pragma mark HexColor
// These code base on: http://imchao.net/2012/01/08/using-hex-value-with-uicolor/
- (UIColor *)ys_initWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
	return [self initWithRed:((hexValue & 0xFF0000) >> 16) / 255.0f
	                   green:((hexValue & 0xFF00) >> 8) / 255.0f
	                    blue:(hexValue & 0xFF) / 255.0f
	                   alpha:alpha];
}

+ (UIColor *)ys_colorWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16) / 255.0f
	                       green:((hexValue & 0xFF00) >> 8) / 255.0f
	                        blue:(hexValue & 0xFF) / 255.0f
	                       alpha:alpha];
}

+ (UIColor *)ys_colorWithRGBHex:(NSInteger)hexValue {
	return [UIColor ys_colorWithRGBHex:hexValue alpha:1.0f];
}

+ (UIColor *)ys_colorWithRGBString:(NSString *)nsstring {
	NSUInteger length = nsstring.length - 1;
//	if (length != 3 && length != 6 ) return [UIColor clearColor];
	if (length != 6) return [UIColor clearColor];
	if ([nsstring characterAtIndex:0] != '#') return [UIColor clearColor];
	int color;
	sscanf([nsstring UTF8String], "#%x", &color);
	return [UIColor ys_colorWithRGBHex:color];
}

+ (UIColor *)ys_colorWithRGBString:(NSString *)nsstring alpha:(CGFloat)alpha {
	NSUInteger length = nsstring.length - 1;
	//	if (length != 3 && length != 6 ) return [UIColor clearColor];
	if (length != 6) return [UIColor clearColor];
	if ([nsstring characterAtIndex:0] != '#') return [UIColor clearColor];
	int color;
	sscanf([nsstring UTF8String], "#%x", &color);
	return [UIColor ys_colorWithRGBHex:color alpha:alpha];
}

+ (UIColor *)ys_colorWithPatternImageName:(NSString *)resourceName {
	return [UIColor colorWithPatternImage:[UIImage imageNamed:resourceName]];
}

+ (UIColor *)ys_randColorWithAlpha:(CGFloat)alpha {
	BOOL fakeRandom = NO;
	if (fakeRandom) {
		return [UIColor colorWithRed:rand() % 255 / 255.f green:rand() % 255 / 255.f blue:rand() % 255 / 255.f alpha:alpha];
	}
	else {
		return [UIColor colorWithRed:arc4random() % 255 / 255.f green:arc4random() % 255 / 255.f blue:arc4random() % 255 / 255.f alpha:alpha];
	}
}

@end
