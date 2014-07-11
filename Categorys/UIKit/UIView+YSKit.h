//
//  UIView+YSKit.h
//  YSCategorys
//
//  Created by YoungShook on 14-7-11.
//  Copyright (c) 2014年 YShook Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YSKit)

/** Creates a snapshot of the receiver.
 
 @return Returns a bitmap image with the same contents and dimensions as the receiver.
 */
- (UIImage *)snapshotImage;

/** Sets the corner attributes of the receiver's layer.
 
 The advantage of using this method is that you do not need to import the QuartzCore headers just for setting the corners.
 @param radius The corner radius.
 @param width The width of the border line.
 @param color The color to be used for the border line. Can be `nil` to leave it unchanged.
 */
- (void)setRoundedCornersWithRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color;


/**---------------------------------------------------------------------------------------
 * @name Shadows
 *  ---------------------------------------------------------------------------------------
 */

/** Adds a layer-based shadow to the receiver.
 
 The advantage of using this method is that you do not need to import the QuartzCore headers just for adding the shadow.
 Layer-based shadows are properly combined for views that are on the same superview. This does not add a shadow path,
 you should call updateShadowPathToBounds whenever the receiver's bounds change and also after setting the initial frame.
 @warn Disables clipping to bounds because this would also clip off the shadow.
 @param color The shadow color. Can be `nil` for default black.
 @param alpha The alpha value of the shadow.
 @param radius The amount that the shadow is blurred.
 @param offset The offset of the shadow
 @see updateShadowPathToBounds:withDuration:
 */
- (void)addShadowWithColor:(UIColor *)color alpha:(CGFloat)alpha radius:(CGFloat)radius offset:(CGSize)offset;


/** sets the shadow path to fit the receiver's bounds.
 
 This should be called whenever the receiver's bounds change, or else the shadow detaches.
 @warn Since this a CALayer property it needs to be explicitly animated, for example in the willRotate ... method of a `UIViewController`.
 @param bounds The new bounds of the shadow path
 @param duration The animation duration. Specify a duration of 0 to not do an animation
 */
- (void)updateShadowPathToBounds:(CGRect)bounds withDuration:(NSTimeInterval)duration;

- (id)subviewWithClassname:(NSString *)classname;
- (void)addSubviewAndPreservePosition:(UIView *)view;

#pragma mark - Animations

- (void)performAnimatedBlock:(void (^)(void))block duration:(CGFloat)duration;

- (void)setAlpha:(CGFloat)alpha animationDuration:(CGFloat)duration;
- (void)rotateToAngle:(CGFloat)angle animationDuration:(CGFloat)duration;
- (void)moveToPoint:(CGPoint)center animationDuration:(CGFloat)duration;

- (void)spinWithVelocity:(CGFloat)velocity forInterval:(NSTimeInterval)interval;


@end
