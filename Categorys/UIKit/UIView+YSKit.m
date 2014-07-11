//
//  UIView+YSKit.m
//  YSCategorys
//
//  Created by YoungShook on 14-7-11.
//  Copyright (c) 2014年 YShook Station. All rights reserved.
//

#import "UIView+YSKit.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (YSKit)

- (UIImage *)snapshotImage
{
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

- (void)setRoundedCornersWithRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color
{
	self.clipsToBounds = YES;
	self.layer.cornerRadius = radius;
	self.layer.borderWidth = width;
	
	if (color)
		{
		self.layer.borderColor = color.CGColor;
		}
}

- (void)addShadowWithColor:(UIColor *)color alpha:(CGFloat)alpha radius:(CGFloat)radius offset:(CGSize)offset
{
	self.layer.shadowOpacity = alpha;
	self.layer.shadowRadius = radius;
	self.layer.shadowOffset = offset;
	
	if (color)
		{
		self.layer.shadowColor = [color CGColor];
		}
	
		// cannot have masking
	self.layer.masksToBounds = NO;
}

- (void)updateShadowPathToBounds:(CGRect)bounds withDuration:(NSTimeInterval)duration
{
	CGPathRef oldPath = self.layer.shadowPath;
	CGPathRef newPath = CGPathCreateWithRect(bounds, NULL);
	
	if (oldPath && duration>0)
		{
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

- (id)subviewWithClassname:(NSString *)classname
{
	for (UIView* view in [self subviews]) {
		
		if ([classname isEqualToString:NSStringFromClass([view class])])
			return view;
		
		UIView* subview = [view subviewWithClassname:classname];
		
		if (subview)
			return subview;
	}
	
	return nil;
}

- (void)addSubviewAndPreservePosition:(UIView *)view
{
	CGPoint center = [self convertPoint:[view center] fromView:[view superview]];
	
	[view setCenter:center];
	[self addSubview:view];
}


#pragma mark - Animations

- (void)performAnimatedBlock:(void (^)(void))block duration:(CGFloat)duration
{
	if (duration > 0.f)
		[UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:block completion:NULL];
	else
		block();
}

- (void)setAlpha:(CGFloat)alpha animationDuration:(CGFloat)duration
{
	[self performAnimatedBlock:^{ [self setAlpha:alpha]; } duration:duration];
}

- (void)rotateToAngle:(CGFloat)angle animationDuration:(CGFloat)duration
{
	[self performAnimatedBlock:^{
		
		[self setTransform:CGAffineTransformMakeRotation(M_PI * (angle))];
		
	} duration:duration];
}

- (void)moveToPoint:(CGPoint)center animationDuration:(CGFloat)duration
{
	[self performAnimatedBlock:^{
		
		[self setCenter:center];
		
	} duration:duration];
}

- (void)spinWithVelocity:(CGFloat)velocity forInterval:(NSTimeInterval)interval
{
	CALayer* layer					= [self layer];
	CATransform3D originalTransform	= [layer transform];
	CATransform3D spinTransform		= CATransform3DMakeRotation(M_PI * 180.f, 0.f, 0.f, 1.f);
	CAKeyframeAnimation* animation	= [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	
	[animation setDuration:velocity];
	[animation setCalculationMode:@"cubicPaced"];
	[animation setRepeatCount:interval];
	[animation setValues:@[[NSValue valueWithCATransform3D:spinTransform],[NSValue valueWithCATransform3D:originalTransform]]];
	
	[layer addAnimation:animation forKey:@"spinAnimation"];
}


@end
