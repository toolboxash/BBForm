

#import "BBConditionPresent.h"
#import "BBFormTextField.h"
#import "BBFormDateField.h"
#import "BBFormSelectField.h"
#import "BBFormAutoCompleteField.h"
#import "BBFormTextView.h"

//#import "BBMultiSelectListFormElement.h"

@implementation BBConditionPresent

- (BOOL)isStringPresent:(NSString *)string//check whether the string value is present or not
{
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
    {
        return NO;
    }
    return YES;
}

- (BOOL)check:(BBFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
    {
        return NO;
    }
    return YES;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationPresent", nil);
}

@end
