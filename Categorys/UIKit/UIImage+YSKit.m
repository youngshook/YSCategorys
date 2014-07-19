#import "UIImage+YSKit.h"

@implementation UIImage (YSKit)

+ (UIImage *)ys_resourceName:(NSString *)PNGFileName {
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:PNGFileName ofType:@"png"]];
}

+ (UIImage *)ys_resourceName:(NSString *)fileName ofType:(NSString *)type {
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:type]];
}

#pragma mark - Snapshot Images

+ (UIImage *)ys_captureView:(UIView *)view {
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

+ (UIImage *)ys_captureFrame:(CGRect)frame inView:(UIView *)view {
	UIGraphicsBeginImageContextWithOptions(frame.size, view.opaque, 0.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(ctx, -frame.origin.x, -frame.origin.y);
	[view.layer renderInContext:ctx];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

#pragma mark - Generating Images

+ (UIImage *)ys_imageWithSolidColor:(UIColor *)color size:(CGSize)size {
	NSParameterAssert(color);
	NSAssert(!CGSizeEqualToSize(size, CGSizeZero), @"Size cannot be CGSizeZero");

	CGRect rect = CGRectMake(0, 0, size.width, size.height);

	// Create a context depending on given size
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);

	// Fill it with your color
	[color setFill];
	UIRectFill(rect);

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

- (UIImage *)ys_imageByScalingAndCroppingForSize:(CGSize)targetSize {
	return [self ys_imageAspectFillSize:targetSize];
}

- (UIImage *)ys_imageMaskedAndTintedWithColor:(UIColor *)color {
	NSParameterAssert(color);

	UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
	CGContextRef ctx = UIGraphicsGetCurrentContext();

	CGRect bounds = (CGRect) {CGPointZero, self.size };

	// do a vertical flip so that image is correct
	CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, bounds.size.height);
	CGContextConcatCTM(ctx, flipVertical);

	// create mask of image
	CGContextClipToMask(ctx, bounds, self.CGImage);

	// fill with given color
	[color setFill];
	CGContextFillRect(ctx, bounds);

	// get back new image
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return retImage;
}

//!ref: http://stackoverflow.com/a/605385/945906
- (UIImage *)ys_imageAspectFillSize:(CGSize)targetSize {
	if (CGSizeEqualToSize(self.size, targetSize)) {
		return [self copy];
	}

	CGFloat xSource = self.size.width;
	CGFloat ySource = self.size.height;
	CGFloat xTarget = targetSize.width;
	CGFloat yTarget = targetSize.height;
	CGRect tmpImageRect = CGRectMake(0, 0, xSource, ySource);
	CGFloat factor;

	if (xSource / ySource > xTarget / yTarget) {
		// 图像按高适配
		factor = yTarget / ySource;
		tmpImageRect.size.width = xSource * factor;
		tmpImageRect.size.height = yTarget;
		tmpImageRect.origin.x = (xTarget - tmpImageRect.size.width) / 2;
	}
	else {
		// 图像按宽度适配
		factor = xTarget / xSource;
		tmpImageRect.size.height = ySource * factor;
		tmpImageRect.size.width = xTarget;
		tmpImageRect.origin.y = (yTarget - tmpImageRect.size.height) / 2;
	}

	UIGraphicsBeginImageContext(targetSize);
	[self drawInRect:tmpImageRect];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	if (!newImage) NSLog(@"Resize Image Faile");
	UIGraphicsEndImageContext();
	return newImage;
}

- (UIImage *)ys_imageAspectFitSize:(CGSize)targetSize {
	if (CGSizeEqualToSize(self.size, targetSize)) {
		return [self copy];
	}

	CGFloat xSource = self.size.width;
	CGFloat ySource = self.size.height;
	CGFloat xTarget = targetSize.width;
	CGFloat yTarget = targetSize.height;
	CGRect tmpImageRect = CGRectMake(0, 0, xSource, ySource);
	CGFloat factor;

	if (xSource / ySource > xTarget / yTarget) {
		// 图像按宽度适配
		factor = xTarget / xSource;
		tmpImageRect.size.height = ySource * factor;
		tmpImageRect.size.width = xTarget;
		tmpImageRect.origin.y = (yTarget - tmpImageRect.size.height) / 2;
	}
	else {
		// 图像按高适配
		factor = yTarget / ySource;
		tmpImageRect.size.width = xSource * factor;
		tmpImageRect.size.height = yTarget;
		tmpImageRect.origin.x = (xTarget - tmpImageRect.size.width) / 2;
	}

	UIGraphicsBeginImageContext(targetSize);
	[self drawInRect:tmpImageRect];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	if (!newImage) NSLog(@"Resize Image Faile");
	UIGraphicsEndImageContext();
	return newImage;
}

//!ref: http://stackoverflow.com/a/7704399/945906
- (UIImage *)ys_imageWithCropRect:(CGRect)rect {
	CGFloat scale = self.scale;
	rect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);

	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
	CGImageRelease(imageRef);
	return result;
}

- (UIImage *)ys_imageWithScaledSize:(CGSize)newSize {
	UIGraphicsBeginImageContext(newSize);
	[self drawInRect:(CGRect) {CGPointZero, newSize }];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	if (!newImage) NSLog(@"Resize Image Faile");
	UIGraphicsEndImageContext();
	return newImage;
}

- (UIImage *)ys_imageWithScale:(CGFloat)scale {
	CGSize newSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
	return [self ys_imageWithScaledSize:newSize];
}

- (UIImage *)ys_imageRotatedByDegrees:(CGFloat)degrees {
	CGFloat radians             = (M_PI * (degrees) / 180.0);
	CGImageRef ref              = [self CGImage];
	CGRect rect                 = { 0.f, 0.f, [self size] };
	CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
	CGRect rotatedRect          = CGRectApplyAffineTransform(rect, transform);
	CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceRGB();

	#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
	#define kCGImageAlphaPremultipliedFirst  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst)
	#else
	#define kCGImageAlphaPremultipliedFirst  kCGImageAlphaPremultipliedFirst
	#endif

	CGContextRef ctx            = CGBitmapContextCreate(NULL, CGRectGetWidth(rotatedRect), CGRectGetHeight(rotatedRect), 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);

	CGContextSetAllowsAntialiasing(ctx, true);
	CGContextSetShouldAntialias(ctx, YES);
	CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
	CGContextTranslateCTM(ctx, CGRectGetWidth(rotatedRect) / 2, CGRectGetHeight(rotatedRect) / 2);
	CGContextRotateCTM(ctx, radians);
	CGContextTranslateCTM(ctx, -CGRectGetWidth(rotatedRect) / 2, -CGRectGetHeight(rotatedRect) / 2);
	CGContextDrawImage(ctx, (CGRect) {0.f, 0.f, rotatedRect.size }, ref);

	CGImageRef rotatedRef   = CGBitmapContextCreateImage(ctx);
	UIImage *image          = [UIImage imageWithCGImage:rotatedRef];

	CGImageRelease(rotatedRef);
	CGColorSpaceRelease(colorSpace);
	CFRelease(ctx);

	return image;
}

#pragma mark - Tint color
- (UIImage *)ys_imageWithTintColor:(UIColor *)tintColor {
	CGRect contextBounds = CGRectMake(0, 0, self.size.width, self.size.height);
	UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);

	[self drawInRect:contextBounds];
	[tintColor setFill];
	UIRectFillUsingBlendMode(contextBounds, kCGBlendModeSourceAtop);

	UIImage *tintImageKeepBright = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return tintImageKeepBright;
}

- (UIImage *)ys_imageOnlyKeepsAlphaWithTintColor:(UIColor *)tintColor {
	CGRect contextBounds = CGRectMake(0, 0, self.size.width, self.size.height);
	UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);

	[self drawInRect:contextBounds];
	[tintColor setFill];
	UIRectFillUsingBlendMode(contextBounds, kCGBlendModeSourceIn);

	UIImage *tintImageKeepAlpha = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return tintImageKeepAlpha;
}

@end
