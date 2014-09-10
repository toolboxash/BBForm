//
//  BBFormTextField.h
//  catch
//
//  Created by Ashley Thwaites on 14/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBStyleView.h"
#import "BBFormElement.h"

typedef enum {
    BBTextInputTypeText,
    BBTextInputTypeNumber,
    BBTextInputTypePassword,
    BBTextInputTypeEmail
} BBTextInputType;


@interface BBFormTextFieldElement : BBFormElement

// Designated initializer
+ (instancetype)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
+ (instancetype)numberInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
+ (instancetype)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
+ (instancetype)emailInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString* placeholderText;
@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* originalValue;
@property (nonatomic, assign) BBTextInputType inputType;

@end


@interface BBFormTextField : BBStyleView <UITextFieldDelegate>

@property (nonatomic, strong) BBFormTextFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic) /*IBInspectable*/ NSString *text;
@property (nonatomic) /*IBInspectable*/ NSString *placeholder;

-(void)textFieldDidChange;
-(void)updateWithElement:(BBFormTextFieldElement*)element;

@end
