
#import "BBValidatorAlphanumeric.h"
#import "BBConditionAlphanumeric.h"


@implementation BBValidatorAlphanumeric


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[BBConditionAlphanumeric alloc] init]];
    }
    
    return self;
}


@end
