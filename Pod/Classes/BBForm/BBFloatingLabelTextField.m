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
#import "BBExtras-UIView.h"

@interface BBFloatingLabelTextField ()
{
    NSLayoutConstraint *floatingLabelCenterConstraint;
    NSLayoutConstraint *textFieldCenterConstraint;
}


@end


@implementation BBFloatingLabelTextField

-(void)setup
{
    _floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _floatingLabel.font = [BBStyleSettings sharedInstance].h2Font;
    _floatingLabel.alpha = 0.0f;

    [super setup];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    [super setContentInsets:contentInsets];

    floatingLabelCenterConstraint = nil;
    textFieldCenterConstraint = nil;

    // remove and readd the views to delete the constraints
    [self.floatingLabel removeFromSuperview];
    [self.floatingLabel removeConstraints:self.floatingLabel.constraints];
    [self addSubview:_floatingLabel];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_floatingLabel])
    {
        [_floatingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
        floatingLabelCenterConstraint = [_floatingLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    if (![self hasConstraintsForView:self.textfield])
    {
        [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
        [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.contentInsets.right];
        textFieldCenterConstraint = [self.textfield autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    [super updateConstraints];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [self.textfield setPlaceholder:placeholder];
    _floatingLabel.text = placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)updateWithElement:(BBFormTextFieldElement*)element
{
    [super updateWithElement:element];
    if (element.value.length >0)
    {
        [self showFloatingLabel:NO];
    }
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
    // calculate the offset
    CGSize labelSize = [_floatingLabel intrinsicContentSize];
    CGSize textSize = [self.textfield intrinsicContentSize];
    floatingLabelCenterConstraint.constant = - ((self.bounds.size.height - labelSize.height) / 2.0f) + self.contentInsets.top;
    textFieldCenterConstraint.constant = ((self.bounds.size.height - textSize.height) / 2.0f) - self.contentInsets.bottom;
    
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