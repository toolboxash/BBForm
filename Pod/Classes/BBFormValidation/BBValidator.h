
#import <Foundation/Foundation.h>
#import "BBCondition.h"
#import "BBConditionCollection.h"
#import "BBFormElement.h"


#pragma mark - Validator protocol

@protocol BBCondition;
@protocol BBConditionCollection;

@protocol BBValidatorProtocol <NSObject>

- (void)addCondition:(id <BBConditionProtocol>)condition;
- (void)removeConditionOfClass:(Class <BBConditionProtocol>)conditionClass;
- (BBConditionCollection *)checkConditions:(NSString *)string;

@end


#pragma mark - Validator interface

@class BBConditionCollection;


@interface BBValidator : NSObject <BBValidatorProtocol>
{
@protected
    BBConditionCollection *_conditionCollection;
}

+ (BBValidator *)validator;

- (id)initWithCondition:(id<BBConditionProtocol>)firstCondition, ...;
- (id)initWithConditions:(NSArray *)conditions;
- (void)setLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index;
- (id)withLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index;
- (id)withLocalizedViolationString:(NSString *)localizedViolationString;
- (void)addCondition:(id <BBConditionProtocol>)condition;
- (void)removeConditionOfClass:(Class <BBConditionProtocol>)conditionClass;

- (BBConditionCollection *)checkConditions:(BBFormElement *)element;


@end

@interface BBValidatorSingleCondition : BBValidator
{
    id<BBConditionProtocol> _condition;
}

@property (strong, nonatomic) id<BBConditionProtocol> condition;
@property (copy, nonatomic) NSString *localizedViolationString;

- (id)initWithCondition:(id<BBConditionProtocol>)condition;

@end
