
#import <Foundation/Foundation.h>

#import "BBCondition.h"

@interface BBConditionAnd : BBCondition
{
    NSMutableArray *_conditions;
}

@property (strong, nonatomic) NSArray *conditions;

- (id)initWithConditions:(NSArray *)originalConditions;

- (id)initWithConditionOne:(id<BBConditionProtocol>)one two:(id<BBConditionProtocol>)two;

@end
