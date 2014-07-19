/*!
    UIView extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>

@interface UIView (YSKit)

#pragma mark - UIView Utils

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat screenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat screenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView *)ys_descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView *)ys_ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)ys_removeAllSubviews;

/**
   Attaches the given block for a single tap action to the receiver.
   @param block The block to execute.
 */
- (void)ys_setTapActionWithBlock:(void (^)(void))block;

/**
   Attaches the given block for a long press action to the receiver.
   @param block The block to execute.
 */
- (void)ys_setLongPressActionWithBlock:(void (^)(void))block;

#pragma mark - UIView Draw

/** Creates a snapshot of the receiver.

   @return Returns a bitmap image with the same contents and dimensions as the receiver.
 */
- (UIImage *)ys_snapshotImage;

/** Sets the corner attributes of the receiver's layer.

   The advantage of using this method is that you do not need to import the QuartzCore headers just for setting the corners.
   @param radius The corner radius.
   @param width The width of the border line.
   @param color The color to be used for the border line. Can be `nil` to leave it unchanged.
 */
- (void)ys_setRoundedCornersWithRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color;


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
- (void)ys_addShadowWithColor:(UIColor *)color alpha:(CGFloat)alpha radius:(CGFloat)radius offset:(CGSize)offset;


/** sets the shadow path to fit the receiver's bounds.

   This should be called whenever the receiver's bounds change, or else the shadow detaches.
   @warn Since this a CALayer property it needs to be explicitly animated, for example in the willRotate ... method of a `UIViewController`.
   @param bounds The new bounds of the shadow path
   @param duration The animation duration. Specify a duration of 0 to not do an animation
 */
- (void)ys_updateShadowPathToBounds:(CGRect)bounds withDuration:(NSTimeInterval)duration;

- (id)ys_subviewWithClassname:(NSString *)classname;
- (void)ys_addSubviewAndPreservePosition:(UIView *)view;

#pragma mark - Animations

- (void)ys_performAnimatedBlock:(void (^)(void))block duration:(CGFloat)duration;

- (void)ys_setAlpha:(CGFloat)alpha animationDuration:(CGFloat)duration;
- (void)ys_rotateToAngle:(CGFloat)angle animationDuration:(CGFloat)duration;
- (void)ys_moveToPoint:(CGPoint)center animationDuration:(CGFloat)duration;

- (void)ys_spinWithVelocity:(CGFloat)velocity forInterval:(NSTimeInterval)interval;


@end
