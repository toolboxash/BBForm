//
//  BBCondition.h


#import <Foundation/Foundation.h>
#import "BBLocalization.h"
#import "BBFormElement.h"

#pragma mark - Condition protocol

@protocol BBConditionProtocol <NSObject>

@required

- (BOOL)check:(BBFormElement *)element;
- (NSString *)localizedViolationString;

@end


#pragma mark - Condition interface


@interface BBCondition : NSObject <BBConditionProtocol>
{
@private
    NSString *_localizedViolationString;
}

@property (copy, nonatomic) NSString *localizedViolationString;
@property (nonatomic, copy) NSString *regexString;

+ (BBCondition *) condition;
- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString;
- (id)withLocalizedViolationString:(NSString *)localizedViolationString;
- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString andRegexString:(NSString *)regexString;
- (id)initWithRegexString:(NSString *)regexString;
- (id)withRegexString:(NSString *)regexString;

@end
