

#import "BBValidator.h"
#import "BBCondition.h"
#import "BBConditionCollection.h"
#import "BBFormElement.h"


@implementation BBValidator

+ (BBValidator *) validator {
    return [[[self class] alloc] init];
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _conditionCollection = [[BBConditionCollection alloc] init];
    }
    
    return self;
}

- (id)initWithCondition:(id<BBConditionProtocol>) firstCondition, ...
{
    if (self = [self init])
    {
        [self addCondition: firstCondition];
        
        va_list args;
        va_start(args, firstCondition);
        
        id<BBConditionProtocol> condition = nil;
        
        while( (condition = va_arg( args, id<BBConditionProtocol>)) != nil )
        {
            [self addCondition: condition];
        }

        va_end(args);
    }
    
    return self;
}

- (id)initWithConditions:(NSArray *) conditions
{
    if (self = [self init])
    {
        for (id<BBConditionProtocol> condition in conditions)
        {
            [self addCondition: condition];
        }
    }
    
    return self;
}

#pragma mark - Deinitialization


#pragma mark - Localized violation string

- (void) setLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index
{
    if (index < [_conditionCollection count])
    {
        id<BBConditionProtocol> conditionProtocol = [_conditionCollection conditionAtIndex:index];
        if ([conditionProtocol isKindOfClass: [BBCondition class]])
        {
            BBCondition *condition = (BBCondition *) conditionProtocol;
            condition.localizedViolationString = localizedViolationString;
        }
    }
}

- (id)withLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index
{
    [self setLocalizedViolationString:localizedViolationString forConditionAtIndex:index];
    return self;
}

- (id)withLocalizedViolationString:(NSString *)localizedViolationString
{
    return [self withLocalizedViolationString:localizedViolationString forConditionAtIndex:0];
}

#pragma mark - Condition


- (void)addCondition:(id <BBConditionProtocol>)condition
{
    if ([condition isKindOfClass:[BBCondition class]])
    {
        [_conditionCollection addCondition:condition];
    }
    else
    {
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added incompatible condition <%@> to validator.", [condition class]], nil];
    }
}


- (void)removeConditionOfClass:(Class <BBConditionProtocol>)conditionClass
{
    for (BBCondition *condition in _conditionCollection)
    {
        if ([condition isKindOfClass:conditionClass])
            [_conditionCollection removeCondition:condition];
    }
}


#pragma mark - Condition check


- (BBConditionCollection *)checkConditions:(BBFormElement *)element
{
    BBConditionCollection *violatedConditions = nil;
    for (BBCondition *condition in _conditionCollection)
    {
        if (NO == [condition check:element])
        {
            if (nil == violatedConditions)
                violatedConditions = [[BBConditionCollection alloc] init];
            
            [violatedConditions addCondition:condition];
        }
    }
    
    return violatedConditions;
}


@end

@implementation BBValidatorSingleCondition

@synthesize condition = _condition;
@dynamic localizedViolationString;

- (id)initWithCondition:(id<BBConditionProtocol>)condition
{
    if (self = [super init])
    {
        [self setCondition: condition];
    }
    
    return self;
}

- (void)setCondition:(id<BBConditionProtocol>)condition
{
    _condition = condition;
    
    [_conditionCollection removeAllConditions];
    [self addCondition: _condition];
}

- (NSString *)localizedViolationString
{
    if ([_conditionCollection count] > 0)
    {
        return [[_conditionCollection conditionAtIndex: 0] localizedViolationString];
    }
    
    return nil;
}

- (void)setLocalizedViolationString:(NSString *)localizedViolationString
{
    [self setLocalizedViolationString: localizedViolationString forConditionAtIndex: 0];
}

@end