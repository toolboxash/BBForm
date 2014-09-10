
#import "BBConditionEmail.h"
#import "BBFormTextField.h"

@implementation BBConditionEmail


- (BOOL)check:(BBFormElement *)element;
{
    if (![element isKindOfClass:[BBFormTextFieldElement class]])
        return NO;
    NSString *string = ((BBFormTextFieldElement*)element).value;
    
    if (nil == string)
        string = [NSString string];
    
    self.regexString = @"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,})+$";
    
    return [super check:element];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationEmail", nil);
}

@end
