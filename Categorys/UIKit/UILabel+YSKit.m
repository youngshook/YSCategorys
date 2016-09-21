#import "UILabel+YSKit.h"

@implementation UILabel (YSKit)

- (CGSize)ys_contentSize {
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineBreakMode = self.lineBreakMode;
	paragraphStyle.alignment = self.textAlignment;

	NSDictionary *attributes = @{ NSFontAttributeName : self.font,
		                          NSParagraphStyleAttributeName : paragraphStyle };

	CGSize contentSize = [self.text boundingRectWithSize:self.frame.size
	                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
	                                          attributes:attributes
	                                             context:nil].size;
	return contentSize;
}

- (float)ys_resizeToFit {
	float height = [self ys_expectedHeight];
	CGRect newFrame = [self frame];
	newFrame.size.height = height;
	[self setFrame:newFrame];
	return newFrame.origin.y + newFrame.size.height;
}

- (float)ys_expectedHeight {
	[self setNumberOfLines:0];

	#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_0
	[self setLineBreakMode:NSLineBreakByWordWrapping];
	#else
	[self setLineBreakMode:UILineBreakModeWordWrap];
	#endif

	CGSize maximumLabelSize = CGSizeMake(self.frame.size.width, 9999);

    CGSize expectedLabelSize =[[self text] boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[self font]} context:nil].size;

	return expectedLabelSize.height;
}

@end
