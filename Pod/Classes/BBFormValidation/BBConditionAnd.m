
#import "BBConditionAnd.h"

@implementation BBConditionAnd
@synthesize conditions = _conditions;

- (id)initWithConditions:(NSArray *)originalConditions
{
    self = [super init];
    if (self)
    {
        self.conditions = [NSMutableArray arrayWithArray:originalConditions];
    }
    
    return self;
}

- (id)initWithConditionOne:(id<BBConditionProtocol>)one two:(id<BBConditionProtocol>)two
{
    self = [self initWithConditions:[NSArray arrayWithObjects: one, two, nil]];
    return self;
}

- (BOOL)check:(BBFormElement *)element;
{
    BOOL result = YES;
    
    for (id<BBConditionProtocol> condition in _conditions)
    {
        result = result && [condition check:element];
    }
    
    return result;
}

#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return nil;
}

@end
