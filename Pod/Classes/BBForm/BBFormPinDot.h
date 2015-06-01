//
//  BBPinDot.h
//  BBForm
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BBPinDotStateUnselected,
    BBPinDotStateHighlighted,
    BBPinDotStateSelected,
} BBPinDotState;


@interface BBFormPinDot : UIView

@property (nonatomic, assign) BBPinDotState state;

-(void)setState:(BBPinDotState)state animated:(BOOL)animated;

@end
