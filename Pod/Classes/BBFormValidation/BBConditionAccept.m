//
//  BBConditionAccept.m
//  monit
//
//  Created by Ashley Thwaites on 23/10/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBConditionAccept.h"
//#import "BBSwitchFormElement.h"

@implementation BBConditionAccept

- (BOOL)check:(BBFormElement *)element;
{
//    if (![element isKindOfClass:[BBSwitchFormElement class]])
//        return NO;
//    
//    return ((BBSwitchFormElement*)element).value;
    return NO;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationAccept", nil);
}

@end
