

#import "BBValidatorPresent.h"
#import "BBConditionPresent.h"

@implementation BBValidatorPresent

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[BBConditionPresent alloc] init]];
    }
    
    return self;
}

@end
