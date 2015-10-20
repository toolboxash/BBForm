//
//  BBExtras-UIAlertController.m
//  BackBone
//
//  Created by Ashley Thwaites on 04/02/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//


#import "BBExtras-UIAlertController.h"
#import "BBFormValidator.h"

@implementation UIAlertController (BBExtras)

+(UIAlertController*)alertWithTitle:(NSString*)title message:(NSString*)message;
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:nil];
    [alertController addAction:okAction];
    return alertController;
}

+(UIAlertController*)alertWithMessage:(NSString*)message;
{
    return [UIAlertController alertWithTitle:nil message:message];
}

+(UIAlertController*)alertWithConditions:(BBConditionCollection*)conditions
{
    BBCondition *cond = [conditions conditionAtIndex:0];
    return [UIAlertController alertWithMessage:cond.localizedViolationString];
}

@end
