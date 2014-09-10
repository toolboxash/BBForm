

#import <Foundation/Foundation.h>
#import "BBCondition.h"


#pragma mark - Condition collection protocol

@class BBConditionCollection;

@protocol BBConditionCollectionProtocol <NSObject>

@required

- (void)addCondition:(id <BBConditionProtocol>)condition;
- (void)removeCondition:(id <BBConditionProtocol>)condition;
- (void)removeConditionAtIndex:(NSUInteger)index;
- (BBCondition *)conditionAtIndex:(NSUInteger)index;

- (void)removeAllConditions;

@end


#pragma mark - Condition collection interface


@interface BBConditionCollection : NSObject <BBConditionCollectionProtocol,
                                              NSFastEnumeration>
{
    NSMutableArray *_array;
}

- (void)addCondition:(id <BBConditionProtocol>)condition;
- (void)removeCondition:(id <BBConditionProtocol>)condition;
- (void)removeConditionAtIndex:(NSUInteger)index;
- (BBCondition *)conditionAtIndex:(NSUInteger)index;

- (void) removeAllConditions;

@property (nonatomic, assign, readonly) NSUInteger count;


@end
