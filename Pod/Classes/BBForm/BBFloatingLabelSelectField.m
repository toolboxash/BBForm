//
//  BBFloatingLabelSelectField.m
//  whatsup
//
//  Created by Ashley Thwaites on 25/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFloatingLabelSelectField.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"

@interface BBFloatingLabelSelectField ()
{
    NSLayoutConstraint *floatingLabelCenterConstraint;
    NSLayoutConstraint *placeholderLabelCenterConstraint;
    NSLayoutConstraint *valueLabelCenterConstraint;
}

@end


@implementation BBFloatingLabelSelectField

-(void)setup
{
    [super setup];
    
    // create the floating label
    _floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _floatingLabel.font = [BBStyleSettings sharedInstance].h2Font;
    _floatingLabel.alpha = 0.0f;
    
    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);

    self.valueLabel.textAlignment = NSTextAlignmentLeft;
    
    // reset contraints on placeholder label, and set the colour

    self.placeholderLabel.textColor = [[BBStyleSettings sharedInstance] unselectedColor];
    
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
        valueLabelCenterConstraint = [self.textfield autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    if(placeholderLabelCenterConstraint == nil)
    {
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        placeholderLabelCenterConstraint = [self.textfield autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    [super updateConstraints];
}


- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    // remove and readd the views to delete the constraints
    [self.floatingLabel removeFromSuperview];
    [self addSubview:_floatingLabel];
    [self.textfield removeFromSuperview];
    [self addSubview:self.textfield];
    [self.valueLabel removeFromSuperview];
    [self addSubview:self.valueLabel];
        
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _floatingLabel.text = placeholder;
    [super setPlaceholder:placeholder];
}

-(void)updateWithElement:(BBFormSelectFieldElement*)element
{
    [super updateWithElement:element];
    if (self.valueLabel.text.length >0)
    {
        [self showFloatingLabel:NO];
    }
}

#pragma mark -
#pragma mark Picker view data source

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [super pickerView:pickerView didSelectRow:row inComponent:component];
    
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
