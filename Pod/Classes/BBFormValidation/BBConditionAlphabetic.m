

#import "BBConditionAlphabetic.h"
#import "BBFormElement.h"
#import "BBFormTextField.h"

#define REGEX_PATTERN @"[a-zA-Z]"
#define REGEX_PATTERN_WHITESPACE @"[a-zA-Z\\s]"

@implementation BBConditionAlphabetic
@synthesize allowWhitespace;

- (BOOL)check:(BBFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
        return NO;
    
    NSString *pattern = REGEX_PATTERN;
    
    if (self.allowWhitespace)
    {
        pattern = REGEX_PATTERN_WHITESPACE;
    }
    
    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    return numberOfMatches == string.length;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationAlphabetic", nil);
}


@end
