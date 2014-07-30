/*!
    UIButton extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UIButton (YSKit)

/**
   Give a image name, this will auto set a button`s image of all state.

   @discussion
   At this time, only png file supported.
   If an image named "test1", it will try set "test1_highlighted.png"
   (or "test1_highlighted@2x.png") for UIControlStateHighlighted. UIControlStateDisabled`s
   suffix is "_disabled", UIControlStateSelected`s is _selected.

   @param imageName   Resource name of the image. Set to nil will not change, set to @""
    will clear the button image.
   @param backGroundImageName Resource name of the background image. Set to nil will not
    change, set to @"" will clear the button background image.
 */
- (void)ys_setResourceImage:(NSString *)imageName background:(NSString *)backGroundImageName;

/** Change the background image to be resizable with the specified cap insets for the specified button state.

   @param capInsets The values to use for the cap insets.
   @param state The state that uses the specified image. The values are described in UIControlState.
 */

- (void)ys_centerImageAndButton:(CGFloat)gap imageOnTop:(BOOL)imageOnTop;

- (void)ys_setBackgroundImageResizingCapInsets:(UIEdgeInsets)capInsets forState:(UIControlState)state NS_AVAILABLE_IOS(5_0);

- (void)ys_setEnlargeEdge:(CGFloat)size;

- (void)ys_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
