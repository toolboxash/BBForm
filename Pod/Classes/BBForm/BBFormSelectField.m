//
//  BBFormSelectField.m
//  whatsup
//
//  Created by Ashley Thwaites on 25/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormSelectField.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "BBExtras-UIView.h"

@implementation BBFormSelectFieldElement

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormSelectFieldElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.values = values;
    element.index = -1;
    element.originalIndex = -1;
    return element;
}

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormSelectFieldElement *element = [self selectElementWithID:elementID labelText:labelText values:values delegate:delegate];
    element.index = index;
    element.originalIndex = index;
    return element;
}

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index insertBlank:(BOOL)insertBlank delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormSelectFieldElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.values = values;
    element.index = -1;
    element.originalIndex = -1;
    element.insertBlank = insertBlank;
    return element;
}

-(NSString*)valueAsString
{
    if ((self.index >=0) && (self.index < self.values.count))
        return [self.values objectAtIndex:self.index];
    return nil;
}

@end


@interface BBFormSelectField ()
{
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;
}

@property (nonatomic, readwrite) UITextField *textfield;
@property (nonatomic, readwrite) UILabel *placeholderLabel;
@property (nonatomic, readwrite) UILabel *valueLabel;
@property (nonatomic, readwrite) UIPickerView *pickerView;

@end


@implementation BBFormSelectField

-(void)setup
{
    [super setup];
    
    // create the value label
    _valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _valueLabel.font = [BBStyleSettings sharedInstance].h1Font;
    _valueLabel.textAlignment = NSTextAlignmentRight;
    
    // create a placeholder label.. same content as floating label but different style
    _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _placeholderLabel.font = [BBStyleSettings sharedInstance].h1Font;
    _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    
    // hidden textfield to trigger the picker...
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;

    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    _textfield.hidden = YES;
    [_textfield setInputView:_pickerView];
    [self addSubview:_textfield];

    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);

    // here we should use a defined style not colour..
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[BBStyleSettings sharedInstance] seperatorColor].CGColor;
    
    insideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapInside:)];
    [self addGestureRecognizer:insideTapGestureRecognizer];
    outsideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOutside:)];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    [_placeholderLabel removeFromSuperview];
    [_placeholderLabel removeConstraints:_placeholderLabel.constraints];
    [self addSubview:_placeholderLabel];
    
    [_valueLabel removeFromSuperview];
    [_valueLabel removeConstraints:_valueLabel.constraints];
    [self addSubview:_valueLabel];
    
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_valueLabel])
    {
        [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        [_valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    
    if (![self hasConstraintsForView:_placeholderLabel])
    {
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        [_placeholderLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    
    [super updateConstraints];
}

-(void)dealloc
{
    [self resignFirstResponder];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)updateWithElement:(BBFormSelectFieldElement*)element
{
    self.element = element;
    self.placeholder = element.labelText;
    self.valueLabel.text = [element valueAsString];
}

- (void)onTapInside:(UIGestureRecognizer*)sender
{
    [_textfield becomeFirstResponder];
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow addGestureRecognizer:outsideTapGestureRecognizer];
}

- (void)onTapOutside:(UIGestureRecognizer*)sender
{
    [_textfield resignFirstResponder];
    [sender.view removeGestureRecognizer:outsideTapGestureRecognizer];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return [_textfield canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textfield becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow removeGestureRecognizer:outsideTapGestureRecognizer];
    return [_textfield resignFirstResponder];
}


#pragma mark -
#pragma mark Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger adjustedRow = (_element.insertBlank) ? row-1:row;
    _valueLabel.text = (adjustedRow<0) ? nil : _element.values[adjustedRow];
    _element.index = adjustedRow;

    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return (_element.insertBlank) ? _element.values.count+1:_element.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSInteger adjustedRow = (_element.insertBlank) ? row-1:row;
    return (adjustedRow<0) ? @"" : _element.values[adjustedRow];
}

-(NSString*)text
{
    return _valueLabel.text;
}


@end
