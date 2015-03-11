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
#import "BBExtras-UIView.h"

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
    // create the additional floating label
    _floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _floatingLabel.font = [BBStyleSettings sharedInstance].h2Font;
    _floatingLabel.alpha = 0.0f;

    [super setup];
    
    self.valueLabel.textAlignment = NSTextAlignmentLeft;
    self.valueLabel.alpha = 0.0f;
    self.placeholderLabel.textColor = [[BBStyleSettings sharedInstance] unselectedColor];
}


- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    [super setContentInsets:contentInsets];

    floatingLabelCenterConstraint = nil;
    placeholderLabelCenterConstraint = nil;
    valueLabelCenterConstraint = nil;
    
    // remove and readd the views to delete the constraints
    [_floatingLabel removeFromSuperview];
    [_floatingLabel removeConstraints:_floatingLabel.constraints];
    [self addSubview:_floatingLabel];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_floatingLabel])
    {
        [_floatingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
        floatingLabelCenterConstraint = [_floatingLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }

    if (![self hasConstraintsForView:self.valueLabel])
    {
        [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
        [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.contentInsets.right];
        valueLabelCenterConstraint = [self.valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    
    if (![self hasConstraintsForView:self.placeholderLabel])
    {
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.contentInsets.right];
        placeholderLabelCenterConstraint = [self.placeholderLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    [super updateConstraints];
}



-(void)setPlaceholder:(NSString *)placeholder
{
    _floatingLabel.text = placeholder;
    [super setPlaceholder:placeholder];
}

-(void)updateWithElement:(BBFormDateFieldElement*)element
{
    [super updateWithElement:element];
    if (self.valueLabel.text.length >0)
    {
        [self showFloatingLabel:NO];
    }
}

-(void)selectedDateDidChange
{
    [super selectedDateDidChange];
    [self showFloatingLabel:YES];
}

// we dont have a hide label method cos currently its not possible to delete a date once weve set one
- (void)showFloatingLabel:(BOOL)animated
{
    CGSize labelSize = [_floatingLabel intrinsicContentSize];
    CGSize textSize = [self.valueLabel intrinsicContentSize];
    floatingLabelCenterConstraint.constant = - ((self.bounds.size.height - labelSize.height) / 2.0f) + self.contentInsets.top;
    valueLabelCenterConstraint.constant = ((self.bounds.size.height - textSize.height) / 2.0f) - self.contentInsets.bottom;
    placeholderLabelCenterConstraint.constant = valueLabelCenterConstraint.constant;
    
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
