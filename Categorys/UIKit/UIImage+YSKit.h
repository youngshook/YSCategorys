/*!
    UIImage extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIImage (YSKit)

+ (UIImage *)ys_resourceName:(NSString *)PNGFileName;
+ (UIImage *)ys_resourceName:(NSString *)fileName ofType:(NSString *)type;

/**
   Captures screen for selected view.

   @param view View that is going to be captured.
   @return View screenshot.
 */
+ (UIImage *)ys_captureView:(UIView *)view;

/**
   Captures frame inside selected view.

   @param frame Frame that is going to be captured.
   @param view View hosting frame.
   @return View frame screenshot.
 */
+ (UIImage *)ys_captureFrame:(CGRect)frame inView:(UIView *)view;

/**
   Creates an image filled with a solid color
   @param color The solid color that fills the image
   @param size The size of the image
   @returns The image filled with given color and given size
 */
+ (UIImage *)ys_imageWithSolidColor:(UIColor *)color size:(CGSize)size;

/**
   Creates an image filled with a tint color using the receiver as image mask. The resulting image ignores the receiver's color values and instead uses the alpha values combined with the passed color.
   @param color The color to use for tinting
   @returns A new image
 */
- (UIImage *)ys_imageMaskedAndTintedWithColor:(UIColor *)color;

// Aspect scale, may crop image
- (UIImage *)ys_imageAspectFillSize:(CGSize)targetSize;

// Aspect scale, no crop
- (UIImage *)ys_imageAspectFitSize:(CGSize)targetSize;

// Crop image, no resize
- (UIImage *)ys_imageWithCropRect:(CGRect)rect;

// Scale image, may change the aspect ratio
- (UIImage *)ys_imageWithScaledSize:(CGSize)newSize;

// Scale image, keep the aspect ratio
- (UIImage *)ys_imageWithScale:(CGFloat)scale;

- (UIImage *)ys_imageByScalingAndCroppingForSize:(CGSize)targetSize DEPRECATED_ATTRIBUTE;


- (UIImage *)ys_imageRotatedByDegrees:(CGFloat)degrees;

#pragma mark - Tint color
/// @name Tint color

/** Creates and returns an tined image object that uses the specified color object.

   This method preserve the highlights, shadows and alpha of the source image.

   @see imageOnlyKeepsAlphaWithTintColor:

   @param tintColor A color used to tint the receiver.

   @return A tinted image.
 */
- (UIImage *)ys_imageWithTintColor:(UIColor *)tintColor;

/** Creates and returns an tined image object that uses the specified color object.

   This method only preserve the alpha of the source image.

   @see imageWithTintColor:

   @param tintColor A color used to tint the receiver.

   @return A tinted image.
 */
- (UIImage *)ys_imageOnlyKeepsAlphaWithTintColor:(UIColor *)tintColor;


@end
