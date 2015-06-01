//
//  BBPinDot.m
//  BBForm
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormPinDot.h"
#import "BBStyleSettings.h"
#import "BBExtras-UIColor.h"

@implementation BBFormPinDot

-(void)setup
{
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
    self.layer.borderWidth = 1.0f;
    self.backgroundColor = [UIColor whiteColor];
    
    self.state = DPPinDotStateUnselected;
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


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
}


-(void)setState:(DPPinDotState)state
{
    [self setState:state animated:NO];
}

-(void)setState:(DPPinDotState)state animated:(BOOL)animated
{
    _state = state;
    
    void (^stateBlock)() = ^{
        switch (_state) {
                
            case DPPinDotStateUnselected:
                self.layer.borderColor = [[BBStyleSettings sharedInstance] unselectedColor].CGColor;
                self.backgroundColor = [UIColor clearColor];
                break;
            case DPPinDotStateHighlighted:
                self.layer.borderColor = [[BBStyleSettings sharedInstance] highlightedColor].CGColor;
                self.backgroundColor = [UIColor clearColor];
                break;
            case DPPinDotStateSelected:
                self.layer.borderColor = [[BBStyleSettings sharedInstance] selectedColor].CGColor;
                self.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
                break;
            default:
                break;
        }
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:stateBlock
                         completion:nil];
    }
    else
    {
        stateBlock();
    }
}

@end
