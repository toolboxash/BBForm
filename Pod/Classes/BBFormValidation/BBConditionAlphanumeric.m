 

#import "BBConditionAlphanumeric.h"
#import "BBFormTextField.h"

@implementation BBConditionAlphanumeric


- (BOOL)check:(BBFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
        return NO;
    
    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9]" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    return numberOfMatches == string.length;
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationAlphanumeric", nil);
}


@end
