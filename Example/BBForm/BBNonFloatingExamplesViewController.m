//
//  BBNonFloatingExamplesViewController.m
//  BBForm
//
//  Created by Ashley Thwaites on 07/02/2015.
//  Copyright (c) 2015 Ashley Thwaites. All rights reserved.
//

#import "BBNonFloatingExamplesViewController.h"
#import "BBFormDateField.h"
#import "BBFormSelectField.h"
#import "BBFormTextField.h"
#import "BBFormTextView.h"
#import "BBFormAutoCompleteField.h"
#import "BBFormPinField.h"
#import "BBFormValidator.h"

@interface BBNonFloatingExamplesViewController () <BBFormElementDelegate>
{
    BBFormTextFieldElement *textFieldElement;
    BBFormSelectFieldElement *selectFieldElement;
    BBFormDateFieldElement *dateFieldElement;
    BBFormTextViewElement *textViewElement;
    BBFormAutoCompleteFieldElement *autoCompleteElement;
    BBFormPinFieldElement *pinElement;
}

@property (nonatomic, strong) IBOutlet BBFormDateField *dateField;
@property (nonatomic, strong) IBOutlet BBFormSelectField *selectField;
@property (nonatomic, strong) IBOutlet BBFormTextField *textField;
@property (nonatomic, strong) IBOutlet BBFormTextView *textView;
@property (nonatomic, strong) IBOutlet BBFormAutoCompleteField *autoTextField;
@property (nonatomic, strong) IBOutlet BBFormPinField *pinField;

@end

@implementation BBNonFloatingExamplesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textFieldElement = [BBFormTextFieldElement textInputElementWithID:0 placeholderText:@"Question" value:nil delegate:self];
    selectFieldElement = [BBFormSelectFieldElement selectElementWithID:1 labelText:@"Select Option" values:@[@"1 minute",@"5 minutes",@"15 minutes",@"1 hour"] index:0 insertBlank:YES delegate:self];    
    dateFieldElement = [BBFormDateFieldElement datePickerElementWithID:2 labelText:@"Enter a date" date:nil datePickerMode:UIDatePickerModeDate delegate:nil];
    textViewElement = [BBFormTextViewElement textViewElementWithID:3 placeholderText:@"Enter some text" value:nil delegate:nil];
    autoCompleteElement = [BBFormAutoCompleteFieldElement selectElementWithID:1 labelText:@"Select Option" values:@[@"Dog",@"Cat",@"Rabbity Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse"] delegate:self];
    autoCompleteElement.displayAllWhenBlank = YES;
    autoCompleteElement.indexRequired = YES;
    pinElement = [BBFormPinFieldElement pinFieldElementWithID:4 pinLength:5 delegate:self];

    if (self.prePopulate)
    {
        textFieldElement.value = @"Some text";
        selectFieldElement.index = 1;
        dateFieldElement.date = [NSDate date];
        textViewElement.value = @"A longer piece of text";
        autoCompleteElement.index = 1;
    }
    
    [_textField updateWithElement:textFieldElement];
    [_selectField updateWithElement:selectFieldElement];
    [_dateField updateWithElement:dateFieldElement];
    [_textView updateWithElement:textViewElement];
    [_autoTextField updateWithElement:autoCompleteElement];
    [_pinField updateWithElement:pinElement];
    
    BBConditionPresent *presentCondition = [[BBConditionPresent alloc] initWithLocalizedViolationString:NSLocalizedString(@"Please complete all fields", @"Please complete all fields")];
    textFieldElement.validator = [[BBValidator alloc] initWithCondition:presentCondition,nil];
    selectFieldElement.validator = [[BBValidator alloc] initWithCondition:presentCondition,nil];
    dateFieldElement.validator = [[BBValidator alloc] initWithCondition:presentCondition,nil];
    textViewElement.validator = [[BBValidator alloc] initWithCondition:presentCondition,nil];
    autoCompleteElement.validator = [[BBValidator alloc] initWithCondition:presentCondition,nil];
    
    self.formModel = @[textFieldElement, selectFieldElement, dateFieldElement, textViewElement, autoCompleteElement];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // create the model
}


@end
