//
//  BBExtras-UIColor.h
//  BackBone
//
//  Created by Ashley Thwaites on 04/02/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIColor (BBExtras)

+ (UIColor *)colorWithHexString:(NSString*)hexString;

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
- (UInt32)rgbaHex;
- (NSString *)hexString;

@end