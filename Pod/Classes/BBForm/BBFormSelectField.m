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
#import "PureLayoutDefines.h"

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
    _valueLabel.alpha = 0.0f;
    [self addSubview:_valueLabel];
    
    [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    _valueLabel.textAlignment = NSTextAlignmentRight;
    
    // create a placeholder label.. same content as floating label but different style
    _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _placeholderLabel.font = [BBStyleSettings sharedInstance].h1Font;
    [self addSubview:_placeholderLabel];
    
    [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_placeholderLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    _valueLabel.textAlignment = NSTextAlignmentLeft;
    
    // hidden textfield to trigger the datepicker...
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;
    
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    _textfield.hidden = YES;
    [_textfield setInputView:_pickerView];
    [self addSubview:_textfield];
    
    // here we should use a defined style not colour..
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[BBStyleSettings sharedInstance] seperatorColor].CGColor;
    
    insideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapInside:)];
    [self addGestureRecognizer:insideTapGestureRecognizer];
    outsideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOutside:)];
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
    if ((element.index >=0) && (element.index < element.values.count))
        self.valueLabel.text = [self.element.values objectAtIndex:element.index];
    else
        self.valueLabel.text = nil;
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
    _valueLabel.text = [self.element.values objectAtIndex:row];
    _element.index = row;
    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }

    // call the bbdelegate to tell it weve changed
    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return _element.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return _element.values[row];
}


-(NSString*)text
{
    return _valueLabel.text;
}


@end
