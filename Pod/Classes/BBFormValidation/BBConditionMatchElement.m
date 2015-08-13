//
//  BBConditionMatchElement.m
//  monit
//
//  Created by Ashley Thwaites on 23/10/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBConditionMatchElement.h"
#import "BBFormTextField.h"

@implementation BBConditionMatchElement

- (id)initWithMatchElement:(BBFormElement *)matchElement;
{
    if (self = [super init])
    {
        self.matchElement = matchElement;
    }
    
    return self;
}

- (BOOL)check:(BBFormElement *)element;
{
    NSString *string = [element valueAsString];
    NSString *matchString = [((BBFormTextFieldElement*)self.matchElement) valueAsString];

    return [string isEqualToString:matchString];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationMatchElement", nil);
}

@end
