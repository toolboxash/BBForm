//
//  BBValidatorAccept.m
//  monit
//
//  Created by Ashley Thwaites on 23/10/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBValidatorAccept.h"
#import "BBConditionAccept.h"

@implementation BBValidatorAccept

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[BBConditionAccept alloc] init]];
    }
    
    return self;
}

@end
