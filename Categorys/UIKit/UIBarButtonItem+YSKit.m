#import "UIBarButtonItem+YSKit.h"

@implementation UIBarButtonItem (YSKit)

+ (UIBarButtonItem *)ys_flexibleSpace {
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

+ (UIBarButtonItem *)ys_spaceWithWidth:(CGFloat)width {
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	[item setWidth:width];

	return item;
}

@end
