
//
//  BBFormTextField.m
//  catch
//
//  Created by Ashley Thwaites on 14/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormTextField.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"



@implementation BBFormTextFieldElement


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBFormTextFieldElement* element = [BBFormTextFieldElement new];
    element.elementID = elementID;
    element.delegate = delegate;
    element.placeholderText = placeholderText;
    element.value = value;
    element.originalValue = value;
    element.inputType = BBTextInputTypeText;
    return element;
}

+ (instancetype)numberInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBFormTextFieldElement* element = [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = BBTextInputTypeNumber;
    return element;
}

+ (instancetype)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBFormTextFieldElement* element = [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = BBTextInputTypePassword;
    return element;
}

+ (instancetype)emailInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBFormTextFieldElement* element = [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = BBTextInputTypeEmail;
    return element;
}

@end



@implementation BBFormTextField

-(void)setup
{
    [super setup];
    
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    [_textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _textfield.font = [BBStyleSettings sharedInstance].h1Font;
    _textfield.delegate = self;
    [self addSubview:_textfield];
    
    [_textfield autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0,0,0,0)];
    
    // here we should use a defined style not colour..
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[BBStyleSettings sharedInstance] seperatorColor].CGColor;
}

-(void)dealloc
{
    [self resignFirstResponder];
}

-(void)updateWithElement:(BBFormTextFieldElement*)element
{
    self.element = element;
    self.placeholder = element.placeholderText;
    self.text = element.value;
    if (element.inputType == BBTextInputTypeNumber)
    {
        _textfield.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (element.inputType == BBTextInputTypeEmail)
    {
        _textfield.keyboardType = UIKeyboardTypeEmailAddress;
        _textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    else
    {
        _textfield.keyboardType = UIKeyboardTypeDefault;
        _textfield.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [_textfield setPlaceholder:placeholder];
    [self setNeedsLayout];
    [self layoutIfNeeded];
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
    return [_textfield resignFirstResponder];
}

-(void)setText:(NSString *)text
{
    _textfield.text = text;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange {
    // call the delegate to inform of value changed
    self.element.value = _textfield.text;
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // call the delegate to inform of value changed
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}



-(NSString*)text
{
    return _textfield.text;
}


@end
