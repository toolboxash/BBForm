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
    
    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);

    self.valueLabel.textAlignment = NSTextAlignmentLeft;
    
    self.placeholderLabel.textColor = [[BBStyleSettings sharedInstance] unselectedColor];
}


- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    floatingLabelCenterConstraint = nil;
    placeholderLabelCenterConstraint = nil;
    valueLabelCenterConstraint = nil;
    
    // remove and readd the views to delete the constraints
    [self.floatingLabel removeFromSuperview];
    [self.floatingLabel removeConstraints:self.floatingLabel.constraints];
    [self addSubview:_floatingLabel];
    
    [self.placeholderLabel removeFromSuperview];
    [self.placeholderLabel removeConstraints:self.placeholderLabel.constraints];
    [self addSubview:self.placeholderLabel];
    
    [self.valueLabel removeFromSuperview];
    [self.valueLabel removeConstraints:self.valueLabel.constraints];
    [self addSubview:self.valueLabel];
    
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
    if(valueLabelCenterConstraint == nil)
    {
        [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        valueLabelCenterConstraint = [self.valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    if(placeholderLabelCenterConstraint == nil)
    {
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        placeholderLabelCenterConstraint = [self.placeholderLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    [super updateConstraints];
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
    CGSize labelSize = [_floatingLabel intrinsicContentSize];
    CGSize textSize = [self.valueLabel intrinsicContentSize];
    floatingLabelCenterConstraint.constant = - ((self.bounds.size.height - labelSize.height) / 2.0f) + _contentInsets.top;
    valueLabelCenterConstraint.constant = ((self.bounds.size.height - textSize.height) / 2.0f) - _contentInsets.bottom;
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
