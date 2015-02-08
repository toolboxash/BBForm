//
//  BBFloatingLabelTextView.m
//  Pods
//
//  Created by Ashley Thwaites on 08/02/2015.
//
//

#import "BBFloatingLabelTextView.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"
#import "BBExtras-UIView.h"

@interface BBFloatingLabelTextView ()
{
    NSLayoutConstraint *placeholderLabelCenterConstraint;
}


@end

@implementation BBFloatingLabelTextView

-(void)setup
{
    [super setup];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    [super setContentInsets:contentInsets];
    
//    floatingLabelCenterConstraint = nil;
//    textFieldCenterConstraint = nil;
    
    // remove and readd the views to delete the constraints
//    [self.floatingLabel removeFromSuperview];
//    [self.floatingLabel removeConstraints:self.floatingLabel.constraints];
//    [self addSubview:_floatingLabel];
}
/*
- (void)updateConstraints
{
    if (![self hasConstraintsForView:_placeholderLabel])
    {
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.contentInsets.top];
    }
    [super updateConstraints];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
*/
/*
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
*/
@end
