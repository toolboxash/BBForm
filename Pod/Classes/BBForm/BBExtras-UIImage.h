//
//  BBExtras-UIImage.h
//  catch
//
//  Created by Ashley Thwaites on 30/06/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BBExtras)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize;

@end
