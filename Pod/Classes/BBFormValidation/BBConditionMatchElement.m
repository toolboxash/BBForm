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
    if (![element isKindOfClass:[BBFormTextFieldElement class]])
        return NO;

    if (![self.matchElement isKindOfClass:[BBFormTextFieldElement class]])
        return NO;
    
    
    NSString *string = ((BBFormTextFieldElement*)element).value;
    NSString *matchString = ((BBFormTextFieldElement*)self.matchElement).value;

    return [string isEqualToString:matchString];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationMatchElement", nil);
}

@end
