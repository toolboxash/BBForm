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
#import "BBFormValidator.h"

@interface BBNonFloatingExamplesViewController () <BBFormElementDelegate>
{
    BBFormTextFieldElement *textFieldElement;
    BBFormSelectFieldElement *selectFieldElement;
    BBFormDateFieldElement *dateFieldElement;
    BBFormTextViewElement *textViewElement;
    BBFormAutoCompleteFieldElement *autoCompleteElement;
}

@property (nonatomic, strong) IBOutlet BBFormDateField *dateField;
@property (nonatomic, strong) IBOutlet BBFormSelectField *selectField;
@property (nonatomic, strong) IBOutlet BBFormTextField *textField;
@property (nonatomic, strong) IBOutlet BBFormTextView *textView;
@property (nonatomic, strong) IBOutlet BBFormAutoCompleteField *autoTextField;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // create the model
}

- (IBAction)verifyPressed:(id)sender {
    
    NSArray *formModel = @[textFieldElement, selectFieldElement, dateFieldElement, textViewElement, autoCompleteElement];
    for (BBFormElement *element in formModel)
    {
        BBValidator *validator = (BBValidator*)element.validator;
        BBConditionCollection *failedConditions = [validator checkConditions:element];
        
        if (failedConditions.count != 0)
        {
            BBCondition *cond = [failedConditions conditionAtIndex:0];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
                                                            message: cond.localizedViolationString
                                                           delegate: nil
                                                  cancelButtonTitle: NSLocalizedString(@"OK", @"OK")
                                                  otherButtonTitles: nil];
            [alert show];
            return;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
                                                    message: @"All verified!"
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString(@"OK", @"OK")
                                          otherButtonTitles: nil];
    [alert show];

}

@end
