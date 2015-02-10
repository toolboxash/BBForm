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
    selectFieldElement = [BBFormSelectFieldElement selectElementWithID:1 labelText:@"Select Option" values:@[@"1 minute",@"5 minutes",@"15 minutes",@"1 hour"] delegate:self];
    dateFieldElement = [BBFormDateFieldElement datePickerElementWithID:2 labelText:@"Enter a date" date:nil datePickerMode:UIDatePickerModeDate delegate:nil];
    textViewElement = [BBFormTextViewElement textViewElementWithID:3 placeholderText:@"Enter some text" value:nil delegate:nil];
    autoCompleteElement = [BBFormAutoCompleteFieldElement selectElementWithID:1 labelText:@"Select Option" values:@[@"Dog",@"Cat",@"Rabbity Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse"] delegate:self];

    [_textField updateWithElement:textFieldElement];
    [_selectField updateWithElement:selectFieldElement];
    [_dateField updateWithElement:dateFieldElement];
    [_textView updateWithElement:textViewElement];
    [_autoTextField updateWithElement:autoCompleteElement];

    // we should add some validations to show how that works too..
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // create the model
}

@end
