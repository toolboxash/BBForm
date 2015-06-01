//
//  BBPinDot.h
//  BBForm
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DPPinDotStateUnselected,
    DPPinDotStateHighlighted,
    DPPinDotStateSelected,
} DPPinDotState;


@interface BBFormPinDot : UIView

@property (nonatomic, assign) DPPinDotState state;

-(void)setState:(DPPinDotState)state animated:(BOOL)animated;

@end
