

#import "BBValidatorComposite.h"

@implementation BBValidatorComposite

@synthesize validators = _validators;

- (id)initWithValidators:(NSArray *)validators
{
    self = [super init];
    if (self)
    {
        self.validators = [NSMutableArray arrayWithArray:validators];
    }
    
    return self;
}

- (id)init
{
    self = [self initWithValidators:[NSArray array]];
    return self;
}

- (void)addValidator:(id<BBValidatorProtocol>)validator
{
    [self.validators addObject:validator];
}

- (void)addValidatorsFromArray:(NSArray *)validators
{
    [self.validators addObjectsFromArray:validators];
}

#pragma mark - Condition check


- (BBConditionCollection *)checkConditions:(NSString *)string
{
    BBConditionCollection *violatedConditions = [super checkConditions: string];
    
    // Check violated conditions of each composite validator
    if (violatedConditions == nil)
    {
        for (id<BBValidatorProtocol> validator in _validators)
        {
            BBConditionCollection *checkedViolatedConditions = [validator checkConditions:string];
            if (checkedViolatedConditions != nil)
            {
                if (violatedConditions == nil)
                {
                    violatedConditions = [[BBConditionCollection alloc] init];
                }
                for (id<BBConditionProtocol> condition in checkedViolatedConditions)
                {
                    [violatedConditions addCondition:condition];
                }
            }
        }
    }
    
    return violatedConditions;
}

@end
