#import "UIButton+YSKit.h"
#import <objc/runtime.h>

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (YSKit)

// Reserved  Selected Disabled Highlighted
- (void)ys_setResourceImage:(NSString *)imageName background:(NSString *)backGroundImageName {
	NSString *file = nil;
	NSString *type = @"png";

	if (imageName.length > 0) {
		file = [[NSBundle mainBundle] pathForResource:imageName ofType:type];
		if (file) {
			[self setImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateNormal];
		}

		file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_highlighted", imageName] ofType:type];
		if (file) {
			[self setImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateHighlighted];
		}

		file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_disabled", imageName] ofType:type];
		if (file) {
			[self setImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateDisabled];
		}

		file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_selected", imageName] ofType:type];
		if (file) {
			[self setImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateSelected];
		}
	}
	else if ([imageName isEqualToString:@""]) {
		[self setImage:nil forState:UIControlStateNormal];
		[self setImage:nil forState:UIControlStateHighlighted];
		[self setImage:nil forState:UIControlStateDisabled];
		[self setImage:nil forState:UIControlStateSelected];
	}

	if (backGroundImageName.length > 0) {
		file = [[NSBundle mainBundle] pathForResource:backGroundImageName ofType:type];
		if (file) {
			[self setBackgroundImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateNormal];
		}

		file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_highlighted", backGroundImageName] ofType:type];
		if (file) {
			[self setBackgroundImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateHighlighted];
		}

		file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_disabled", backGroundImageName] ofType:type];
		if (file) {
			[self setBackgroundImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateDisabled];
		}

		file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_selected", backGroundImageName] ofType:type];
		if (file) {
			[self setBackgroundImage:[UIImage imageWithContentsOfFile:file] forState:UIControlStateSelected];
		}
	}
	else if ([backGroundImageName isEqualToString:@""]) {
		[self setBackgroundImage:nil forState:UIControlStateNormal];
		[self setBackgroundImage:nil forState:UIControlStateHighlighted];
		[self setBackgroundImage:nil forState:UIControlStateDisabled];
		[self setBackgroundImage:nil forState:UIControlStateSelected];
	}
}

- (void)ys_setBackgroundImageResizingCapInsets:(UIEdgeInsets)capInsets forState:(UIControlState)state {
	UIImage *ri = [[self backgroundImageForState:state] resizableImageWithCapInsets:capInsets];
	[self setBackgroundImage:ri forState:state];
}

- (void)ys_centerImageAndButton:(CGFloat)gap imageOnTop:(BOOL)imageOnTop {
	NSInteger sign = imageOnTop ? 1 : -1;

	CGSize imageSize = self.imageView.frame.size;
	self.titleEdgeInsets = UIEdgeInsetsMake((imageSize.height + gap) * sign, -imageSize.width, 0, 0);

	CGSize titleSize = self.titleLabel.bounds.size;
	self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + gap) * sign, 0, 0, -titleSize.width);
}

#pragma mark - Button EnlargeEdge

- (void)ys_setEnlargeEdge:(CGFloat)size {
	objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)ys_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
	objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
	objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
	NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey);
	NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
	NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
	NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
	if (topEdge && rightEdge && bottomEdge && leftEdge) {
		return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
		                  self.bounds.origin.y - topEdge.floatValue,
		                  self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
		                  self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
	}
	else {
		return self.bounds;
	}
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	CGRect rect = [self enlargedRect];
	if (CGRectEqualToRect(rect, self.bounds)) {
		return [super hitTest:point withEvent:event];
	}
	return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
