

#import <Foundation/Foundation.h>

#import "BBValidator.h"


#pragma mark - Validator interface


@interface BBValidatorRange : BBValidatorSingleCondition
{
@protected
    NSRange _range;
}


@property (nonatomic, assign) NSRange range;


- (id) initWithRange: (NSRange) range;

@end
