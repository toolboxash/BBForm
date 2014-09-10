  

#import "BBValidatorNumeric.h"
#import "BBConditionNumeric.h"


@implementation BBValidatorNumeric


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[BBConditionNumeric alloc] init]];
    }
    
    return self;
}


@end
