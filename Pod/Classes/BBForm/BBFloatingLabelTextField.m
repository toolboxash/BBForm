//
//  BBFloatingLabelTextField.m
//  catch
//
//  Created by Ashley Thwaites on 04/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFloatingLabelTextField.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"

@interface BBFloatingLabelTextField ()
{
    NSLayoutConstraint *floatingLabelCenterConstraint;
    NSLayoutConstraint *textFieldCenterConstraint;
}


@end


@implementation BBFloatingLabelTextField

-(void)setup
{
    [super setup];
    
    _floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _floatingLabel.font = [BBStyleSettings sharedInstance].h2Font;
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];

    [_floatingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    floatingLabelCenterConstraint = [_floatingLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    
    [self.textfield autoRemoveConstraintsAffectingView];
    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    textFieldCenterConstraint = [self.textfield autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [self.textfield setPlaceholder:placeholder];
    _floatingLabel.text = placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


-(void)setText:(NSString *)text
{
    self.textfield.text = text;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)textFieldDidChange {
    [super textFieldDidChange];
    
    // whatever you wanted to do
    BOOL firstResponder = self.textfield.isFirstResponder;
    //        _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ? self.getLabelActiveColor : self.floatingLabelTextColor);
    
    if (!self.textfield.text || 0 == [self.textfield.text length])
    {
        [self hideFloatingLabel:firstResponder];
    }
    else
    {
        [self showFloatingLabel:firstResponder];
    }
}

- (void)showFloatingLabel:(BOOL)animated
{
    floatingLabelCenterConstraint.constant = -8.0f;
    textFieldCenterConstraint.constant = 12.0f;
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
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

- (void)hideFloatingLabel:(BOOL)animated
{
    floatingLabelCenterConstraint.constant = 0.0f;
    textFieldCenterConstraint.constant = 0.0f;
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
        [self layoutIfNeeded];
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else
    {
        hideBlock();
    }
}

@end