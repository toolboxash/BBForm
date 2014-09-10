//
//  BBExtras-UIColor.m
//  BackBone
//
//  Created by Ashley Thwaites on 04/02/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import "BBExtras-UIColor.h"

@implementation UIColor (BBExtras)

+ (UIColor *)colorWithHexString:(NSString*)hexString
{
	if (hexString == nil)
	{
		return [UIColor blackColor];
	}
	
	
	
	// swap # for 0x
	NSString *hex = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
	NSScanner *aScanner = [NSScanner scannerWithString:hex];
	unsigned int tempInt;
	[aScanner scanHexInt:&tempInt];

	return [UIColor colorWithRed:((tempInt>>16)&0xFF)/255.0 green:((tempInt>>8)&0xFF)/255.0	blue:(tempInt&0xFF)/255.0	alpha:1.0];
}

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:	// We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

- (UInt32)rgbaHex {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(r, 0.0f), 1.0f);
    g = MIN(MAX(g, 0.0f), 1.0f);
    b = MIN(MAX(b, 0.0f), 1.0f);
    a = MIN(MAX(a, 0.0f), 1.0f);
    
    return (((UInt32)roundf(r * 255)) << 24)
    | (((UInt32)roundf(g * 255)) << 16)
    | (((UInt32)roundf(b * 255)) << 16)
    | (((UInt32)roundf(a * 255)));
}

- (NSString *)hexString {
    return [NSString stringWithFormat:@"%0.8X", (unsigned int)self.rgbaHex];
}


@end
