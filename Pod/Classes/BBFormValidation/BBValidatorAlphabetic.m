

#import "BBValidatorAlphabetic.h"
#import "BBConditionAlphabetic.h"


@implementation BBValidatorAlphabetic
@dynamic allowWhitespace;

#pragma mark - Initialization

- (id)init
{
    self = [super initWithCondition:[[BBConditionAlphabetic alloc] init]];
    if (self)
    {
    }
        
    return self;
}

- (BOOL)allowWhitespace
{
    return [(BBConditionAlphabetic *)[self condition] allowWhitespace];
}

- (void)setAllowWhitespace:(BOOL)allowWhitespace
{
    [(BBConditionAlphabetic *)[self condition] setAllowWhitespace:allowWhitespace];
}

@end
