//
//  BBStyleButton.m
//  catch
//
//  Created by Ashley Thwaites on 10/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBStyleButton.h"

@implementation BBStyleButton


-(void)setup
{
    _borderColor = [UIColor blackColor];
    _borderWidth = 0;
    _cornerRadius = 0;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}

- (void) setBorderWidth:(NSInteger)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void) setCornerRadius:(NSInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}



@end
