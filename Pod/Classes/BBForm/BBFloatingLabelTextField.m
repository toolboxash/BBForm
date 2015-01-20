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
    
    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;

    // remove and readd the views to delete the constraints
    [self.floatingLabel removeFromSuperview];
    [self addSubview:_floatingLabel];
    [self.textfield removeFromSuperview];
    [self addSubview:self.textfield];
    
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (floatingLabelCenterConstraint == nil)
    {
        [_floatingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        floatingLabelCenterConstraint = [_floatingLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    if(textFieldCenterConstraint == nil)
    {
        [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
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
    floatingLabelCenterConstraint.constant = - ((self.bounds.size.height - labelSize.height) / 2.0f) + _contentInsets.top;
    textFieldCenterConstraint.constant = ((self.bounds.size.height - textSize.height) / 2.0f) - _contentInsets.bottom;
    
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