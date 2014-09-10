

#import <Foundation/Foundation.h>
#import "BBCondition.h"

@interface BBConditionNot : BBCondition
{
    
}

@property (strong, nonatomic) id<BBConditionProtocol> condition;

- (id)initWithCondition:(id<BBConditionProtocol>)originalCondition;

@end
