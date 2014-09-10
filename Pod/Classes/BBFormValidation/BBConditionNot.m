
#import "BBConditionNot.h"

@implementation BBConditionNot
@synthesize condition;

- (id)initWithCondition:(id<BBConditionProtocol>)originalCondition
{
    self = [super init];
    if (self)
    {
        self.condition = originalCondition;
    }
    
    return self;
}

- (BOOL)check:(BBFormElement *)element;
{
    BOOL result = [self.condition check:element];
    return !result;
}

#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return nil;
}

@end
