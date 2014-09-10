

#import <Foundation/Foundation.h>
#import "BBValidator.h"


@interface BBValidatorComposite : BBValidator {
@private
    NSMutableArray *_validators;
}

@property (strong, nonatomic) NSMutableArray *validators;


- (id)initWithValidators:(NSArray *)validators;
- (void)addValidator:(id<BBValidatorProtocol>)validator;
- (void)addValidatorsFromArray:(NSArray *)validators;

@end
