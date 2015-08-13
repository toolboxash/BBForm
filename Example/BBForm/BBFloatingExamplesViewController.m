//
//  BBViewController.m
//  BBForm
//
//  Created by Ashley Thwaites on 09/10/2014.
//  Copyright (c) 2014 Ashley Thwaites. All rights reserved.
//

#import "BBFloatingExamplesViewController.h"
#import "BBFloatingLabelDateField.h"
#import "BBFloatingLabelSelectField.h"
#import "BBFloatingLabelTextField.h"
#import "BBFloatingLabelTextView.h"
#import "BBFloatingLabelAutoCompleteField.h"
#import "BBFormValidator.h"

@interface BBFloatingExamplesViewController () <BBFormElementDelegate>
{
    BBFormTextFieldElement *textFieldElement;
    BBFormSelectFieldElement *selectFieldElement;
    BBFormDateFieldElement *dateFieldElement;
    BBFormTextViewElement *textViewElement;
    BBFormAutoCompleteFieldElement *autoCompleteElement;
}

@property (nonatomic, strong) IBOutlet BBFloatingLabelDateField *dateField;
@property (nonatomic, strong) IBOutlet BBFloatingLabelSelectField *selectField;
@property (nonatomic, strong) IBOutlet BBFloatingLabelTextField *textField;
@property (nonatomic, strong) IBOutlet BBFloatingLabelTextView *textView;
@property (nonatomic, strong) IBOutlet BBFloatingLabelAutoCompleteField *autoTextField;

@end

@implementation BBFloatingExamplesViewController

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
