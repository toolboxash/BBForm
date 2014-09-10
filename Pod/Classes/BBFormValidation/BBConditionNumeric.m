
#import "BBConditionNumeric.h"
#import "BBFormTextField.h"

@implementation BBConditionNumeric


- (BOOL)check:(BBFormElement *)element;
{
    if (![element isKindOfClass:[BBFormTextFieldElement class]])
        return NO;
    NSString *string = ((BBFormTextFieldElement*)element).value;
    
    if (nil == string)
    {
        return NO;
    }
    
    self.regexString = @"\\d+";
    
    return [super check:element];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationNumeric", nil);
}


@end
