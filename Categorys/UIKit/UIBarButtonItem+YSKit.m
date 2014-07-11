
#import "UIBarButtonItem+YSKit.h"

@implementation UIBarButtonItem (YSKit)

+ (UIBarButtonItem *)flexibleSpace
{
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

+ (UIBarButtonItem *)spaceWithWidth:(CGFloat)width
{
	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	[item setWidth:width];
	
	return item;
}

@end
