

#import "BBConditionCollection.h"


@implementation BBConditionCollection


@dynamic count;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _array  = [NSMutableArray array];
    }
    
    return self;
}



#pragma mark - Manipulation

- (void)addCondition:(id <BBConditionProtocol>)condition
{
    [_array addObject:condition];
}

- (void)removeCondition:(id <BBConditionProtocol>)condition
{
    [_array removeObject:condition];
}

- (void)removeConditionAtIndex:(NSUInteger)index
{
    [_array removeObjectAtIndex:index];
}

- (BBCondition *)conditionAtIndex:(NSUInteger)index
{
    return [_array objectAtIndex:index];
}

- (void) removeAllConditions {
    [_array removeAllObjects];
}

#pragma mark - Fast enumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id *)buffer count:(NSUInteger)len
{
    return [_array countByEnumeratingWithState:state objects:buffer count:len];
}


#pragma mark - Information

- (NSUInteger)count
{
    return _array.count;
}


#pragma mark - Description


- (NSString *)description
{
    NSMutableString *description = [NSMutableString string];
    for (BBCondition *condition in _array)
    {
        [description appendString:condition.description];
    }
    
    return description;
}


@end
