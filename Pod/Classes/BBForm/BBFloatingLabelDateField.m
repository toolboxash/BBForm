//
//  BBDateField.m
//  catch
//
//  Created by Ashley Thwaites on 08/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFloatingLabelDateField.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"

@interface BBFloatingLabelDateField ()
{
    NSLayoutConstraint *floatingLabelCenterConstraint;
    NSLayoutConstraint *placeholderLabelCenterConstraint;
    NSLayoutConstraint *valueLabelCenterConstraint;
}

@end

@implementation BBFloatingLabelDateField

-(void)setup
{
    [super setup];
    
    // create the floating label
    _floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _floatingLabel.font = [BBStyleSettings sharedInstance].h2Font;
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
    
    [_floatingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    floatingLabelCenterConstraint = [_floatingLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];

    // redo the value label constraints
    [self.valueLabel autoRemoveConstraintsAffectingView];
    [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    valueLabelCenterConstraint = [self.valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    self.valueLabel.textAlignment = NSTextAlignmentLeft;
    
    // create a placeholder label.. same content as floating label but different style
    [self.placeholderLabel autoRemoveConstraintsAffectingView];
    [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    placeholderLabelCenterConstraint = [self.placeholderLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
}


-(void)setPlaceholder:(NSString *)placeholder
{
    _floatingLabel.text = placeholder;
    [super setPlaceholder:placeholder];
}

-(void)selectedDateDidChange
{
    [super selectedDateDidChange];
    [self showFloatingLabel:YES];
}

// we dont have a hide label method cos currently its not possible to delete a date once weve set one
- (void)showFloatingLabel:(BOOL)animated
{
    floatingLabelCenterConstraint.constant = -8.0f;
    valueLabelCenterConstraint.constant = 12.0f;
    placeholderLabelCenterConstraint.constant = 12.0f;
    
    void (^showBlock)() = ^{
        self.floatingLabel.alpha = 1.0f;
        self.valueLabel.alpha = 1.0f;
        self.placeholderLabel.alpha = 0.0f;
        [self layoutIfNeeded];
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else
    {
        showBlock();
    }
}



@end
