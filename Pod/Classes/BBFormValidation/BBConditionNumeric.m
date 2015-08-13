
#import "BBConditionNumeric.h"
#import "BBFormTextField.h"

@implementation BBConditionNumeric


- (BOOL)check:(BBFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
        return NO;
    
    self.regexString = @"\\d+";
    
    return [super check:element];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationNumeric", nil);
}


@end
