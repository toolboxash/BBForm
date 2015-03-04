
#import "BBConditionEmail.h"
#import "BBFormTextField.h"

@implementation BBConditionEmail

- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString {
    return [super initWithLocalizedViolationString:localizedViolationString andRegexString:@"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,})+$"];
}

#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationEmail", nil);
}

@end
