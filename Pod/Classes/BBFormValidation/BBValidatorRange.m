
#import "BBValidatorRange.h"
#import "BBConditionRange.h"


@implementation BBValidatorRange


@synthesize range = _range;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        BBConditionRange *rangeCondition = [[BBConditionRange alloc] init];
        [self addCondition:rangeCondition];
    }
    
    return self;
}

- (id)initWithRange:(NSRange)range
{
    self = [super init];
    if(self)
    {
        [self setRange: range];
    }

    return self;
}


#pragma mark - Range

- (void)setRange:(NSRange)range
{
    _range = range;
    
    // Remove all added range coniditons
    [self removeConditionOfClass:[BBConditionRange class]];
    
    // Add new range condition
    BBConditionRange *rangeCondition   = [[BBConditionRange alloc] init];
    rangeCondition.range                = _range;
    [self addCondition:rangeCondition];
}


@end
