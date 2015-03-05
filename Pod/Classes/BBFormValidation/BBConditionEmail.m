
#import "BBConditionEmail.h"
#import "BBFormTextField.h"

#define kRegularExpressionEmail @"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,})+$"

@implementation BBConditionEmail

- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString
{
    return [super initWithLocalizedViolationString:localizedViolationString andRegexString:kRegularExpressionEmail];
}

- (id)init
{
    return [super initWithRegexString:kRegularExpressionEmail];
}

#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationEmail", nil);
}

@end
