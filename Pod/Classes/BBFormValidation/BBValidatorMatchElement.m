//
//  BBValidatorMatchElement.m
//  monit
//
//  Created by Ashley Thwaites on 23/10/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBValidatorMatchElement.h"
#import "BBConditionMatchElement.h"

@implementation BBValidatorMatchElement

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[BBConditionMatchElement alloc] init]];
    }
    
    return self;
}

@end
