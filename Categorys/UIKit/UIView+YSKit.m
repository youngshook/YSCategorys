#import "UIView+YSKit.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

@implementation UIView (YSKit)

#pragma mark - UIView Utils

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)centerX {
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)screenX {
	CGFloat x = 0.0f;
	for (UIView *view = self; view; view = view.superview) {
		x += view.left;
	}
	return x;
}

- (CGFloat)screenY {
	CGFloat y = 0.0f;
	for (UIView *view = self; view; view = view.superview) {
		y += view.top;
	}
	return y;
}

- (CGFloat)screenViewX {
	CGFloat x = 0.0f;
	for (UIView *view = self; view; view = view.superview) {
		x += view.left;

		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView *scrollView = (UIScrollView *)view;
			x -= scrollView.contentOffset.x;
		}
	}

	return x;
}

- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView *view = self; view; view = view.superview) {
		y += view.top;

		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView *scrollView = (UIScrollView *)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGRect)screenFrame {
	return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (CGFloat)orientationWidth {
	return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
	       ? self.height : self.width;
}

- (CGFloat)orientationHeight {
	return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
	       ? self.width : self.height;
}

- (UIView *)ys_descendantOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls])
		return self;

	for (UIView *child in self.subviews) {
		UIView *it = [child ys_descendantOrSelfWithClass:cls];
		if (it)
			return it;
	}

	return nil;
}

- (UIView *)ys_ancestorOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls]) {
		return self;
	}
	else if (self.superview) {
		return [self.superview ys_ancestorOrSelfWithClass:cls];
	}
	else {
		return nil;
	}
}

- (void)ys_removeAllSubviews {
	while (self.subviews.count) {
		UIView *child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (CGPoint)ys_offsetFromView:(UIView *)otherView {
	CGFloat x = 0.0f, y = 0.0f;
	for (UIView *view = self; view && view != otherView; view = view.superview) {
		x += view.left;
		y += view.top;
	}
	return CGPointMake(x, y);
}

- (void)ys_setTapActionWithBlock:(void (^)(void))block {
	UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);

	if (!gesture) {
		gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}

	objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		void (^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);

		if (action) {
			action();
		}
	}
}

- (void)ys_setLongPressActionWithBlock:(void (^)(void))block {
	UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);

	if (!gesture) {
		gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}

	objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateBegan) {
		void (^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);

		if (action) {
			action();
		}
	}
}

#pragma mark - UIView Draw

- (UIImage *)ys_snapshotImage {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

- (void)ys_setRoundedCornersWithRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color {
	self.clipsToBounds = YES;
	self.layer.cornerRadius = radius;
	self.layer.borderWidth = width;

	if (color) {
		self.layer.borderColor = color.CGColor;
	}
}

- (void)ys_addShadowWithColor:(UIColor *)color alpha:(CGFloat)alpha radius:(CGFloat)radius offset:(CGSize)offset {
	self.layer.shadowOpacity = alpha;
	self.layer.shadowRadius = radius;
	self.layer.shadowOffset = offset;

	if (color) {
		self.layer.shadowColor = [color CGColor];
	}

	// cannot have masking
	self.layer.masksToBounds = NO;
}

- (void)ys_updateShadowPathToBounds:(CGRect)bounds withDuration:(NSTimeInterval)duration {
	CGPathRef oldPath = self.layer.shadowPath;
	CGPathRef newPath = CGPathCreateWithRect(bounds, NULL);

	if (oldPath && duration > 0) {
		CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
		theAnimation.duration = duration;
		theAnimation.fromValue = (__bridge id)oldPath;
		theAnimation.toValue = (__bridge id)newPath;
		theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		[self.layer addAnimation:theAnimation forKey:@"shadowPath"];
	}

	self.layer.shadowPath = newPath;

	CGPathRelease(newPath);
}

- (id)ys_subviewWithClassname:(NSString *)classname {
	for (UIView *view in[self subviews]) {
		if ([classname isEqualToString:NSStringFromClass([view class])])
			return view;

		UIView *subview = [view ys_subviewWithClassname:classname];

		if (subview)
			return subview;
	}

	return nil;
}

- (void)ys_addSubviewAndPreservePosition:(UIView *)view {
	CGPoint center = [self convertPoint:[view center] fromView:[view superview]];

	[view setCenter:center];
	[self addSubview:view];
}

#pragma mark - Animations

- (void)ys_performAnimatedBlock:(void (^)(void))block duration:(CGFloat)duration {
	if (duration > 0.f)
		[UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:block completion:NULL];
	else
		block();
}

- (void)ys_setAlpha:(CGFloat)alpha animationDuration:(CGFloat)duration {
	[self ys_performAnimatedBlock: ^{ [self setAlpha:alpha]; } duration:duration];
}

- (void)ys_rotateToAngle:(CGFloat)angle animationDuration:(CGFloat)duration {
	[self ys_performAnimatedBlock: ^{
	    [self setTransform:CGAffineTransformMakeRotation(M_PI * (angle))];
	} duration:duration];
}

- (void)ys_moveToPoint:(CGPoint)center animationDuration:(CGFloat)duration {
	[self ys_performAnimatedBlock: ^{
	    [self setCenter:center];
	} duration:duration];
}

- (void)ys_spinWithVelocity:(CGFloat)velocity forInterval:(NSTimeInterval)interval {
	CALayer *layer                  = [self layer];
	CATransform3D originalTransform = [layer transform];
	CATransform3D spinTransform     = CATransform3DMakeRotation(M_PI * 180.f, 0.f, 0.f, 1.f);
	CAKeyframeAnimation *animation  = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

	[animation setDuration:velocity];
	[animation setCalculationMode:@"cubicPaced"];
	[animation setRepeatCount:interval];
	[animation setValues:@[[NSValue valueWithCATransform3D:spinTransform], [NSValue valueWithCATransform3D:originalTransform]]];

	[layer addAnimation:animation forKey:@"spinAnimation"];
}

@end
