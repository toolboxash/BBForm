

#import "BBValidatorEmail.h"
#import "BBConditionEmail.h"


@implementation BBValidatorEmail


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[BBConditionEmail alloc] init]];
    }
    
    return self;
}


@end
