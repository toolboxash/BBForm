//
//  BBFormViewController.m
//  BBForm
//
//  Created by Ash Thwaites on 11/03/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import "BBFormViewController.h"
#import "BBForm.h"
#import "BBFormValidator.h"

@interface BBFormViewController ()

@end

@implementation BBFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)verifyPressed:(id)sender {
    
    for (BBFormElement *element in self.formModel)
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
