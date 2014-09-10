

#import "BBConditionAlphabetic.h"
#import "BBFormElement.h"
#import "BBFormTextField.h"

#define REGEX_PATTERN @"[a-zA-Z]"
#define REGEX_PATTERN_WHITESPACE @"[a-zA-Z\\s]"

@implementation BBConditionAlphabetic
@synthesize allowWhitespace;

- (BOOL)check:(BBFormElement *)element;
{
    if (![element isKindOfClass:[BBFormTextFieldElement class]])
        return NO;
    NSString *string = ((BBFormTextFieldElement*)element).value;
    
    if (nil == string || [string isEqualToString: @""])
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
