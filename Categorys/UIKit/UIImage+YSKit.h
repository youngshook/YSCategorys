/*!
    UIImage extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIImage (YSKit)

+ (UIImage *)resourceName:(NSString *)PNGFileName;
+ (UIImage *)resourceName:(NSString *)fileName ofType:(NSString *)type;

/**
 Creates an image filled with a solid color
 @param color The solid color that fills the image
 @param size The size of the image
 @returns The image filled with given color and given size
 */
+ (UIImage *)imageWithSolidColor:(UIColor *)color size:(CGSize)size;

/**
 Creates an image filled with a tint color using the receiver as image mask. The resulting image ignores the receiver's color values and instead uses the alpha values combined with the passed color.
 @param color The color to use for tinting
 @returns A new image
 */
- (UIImage *)imageMaskedAndTintedWithColor:(UIColor *)color;

// Aspect scale, may crop image
- (UIImage *)imageAspectFillSize:(CGSize)targetSize;

// Aspect scale, no crop
- (UIImage *)imageAspectFitSize:(CGSize)targetSize;

// Crop image, no resize
- (UIImage *)imageWithCropRect:(CGRect)rect;

// Scale image, may change the aspect ratio
- (UIImage *)imageWithScaledSize:(CGSize)newSize;

// Scale image, keep the aspect ratio
- (UIImage*)imageWithScale:(CGFloat)scale;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize DEPRECATED_ATTRIBUTE;


- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

#pragma mark - Tint color
/// @name Tint color

/** Creates and returns an tined image object that uses the specified color object.

 This method preserve the highlights, shadows and alpha of the source image.

 @see imageOnlyKeepsAlphaWithTintColor:

 @param tintColor A color used to tint the receiver.

 @return A tinted image.
*/
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

/** Creates and returns an tined image object that uses the specified color object.

 This method only preserve the alpha of the source image.

 @see imageWithTintColor:

 @param tintColor A color used to tint the receiver.

 @return A tinted image.
*/
- (UIImage *)imageOnlyKeepsAlphaWithTintColor:(UIColor *)tintColor;


@end
