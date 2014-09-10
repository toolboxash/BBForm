
#import <Foundation/Foundation.h>
#import "BBValidator.h"


#pragma mark - Validator interface

@interface BBValidatorAlphabetic : BBValidatorSingleCondition
{
}

@property (nonatomic) BOOL allowWhitespace;


@end