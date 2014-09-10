
#import "BBCondition.h"
#import "BBFormTextField.h"


@implementation BBCondition

@synthesize localizedViolationString = _localizedViolationString;
@synthesize regexString = _regex;

#pragma mark - Init

+ (BBCondition *)condition
{
    return [[[self class] alloc] init];
}

- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString
{
    if (self = [super init])
    {
        self.localizedViolationString = localizedViolationString;
    }
    
    return self;
}

- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString andRegexString:(NSString *)regexString
{
    if (self = [super init])
    {
        self.localizedViolationString = localizedViolationString;
        self.regexString = regexString;
    }
    
    return self;
}

- (id)initWithRegexString:(NSString *)regexString
{
    if (self = [super init])
    {
        self.regexString = regexString;
    }
    
    return self;
}

- (id)withRegexString:(NSString *)regexString
{
    self.regexString = regexString;
    return self;
}

- (id)withLocalizedViolationString:(NSString *)localizedViolationString
{
    self.localizedViolationString = localizedViolationString;
    return self;
}


#pragma mark - Check

- (BOOL)check:(BBFormElement *)element;
{
    if (![element isKindOfClass:[BBFormTextFieldElement class]])
        return NO;
    NSString *string = ((BBFormTextFieldElement*)element).value;
 
    BOOL success = YES;
    
    if(!string)
    {
        success = NO;
    }
    else if(self.regexString)
    {
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.regexString options:NSRegularExpressionCaseInsensitive error:&error];
        if(!error)
        {
            NSRange matchRange = [regex rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
            success = (matchRange.location == 0) && (matchRange.length == string.length);
        }
    }
    
    return success;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return nil;
}

- (NSString *)localizedViolationString
{
    if (!_localizedViolationString)
    {
        return [self createLocalizedViolationString];
    }
    
    return _localizedViolationString;
}


#pragma mark - Description

- (NSString *)description
{
    NSMutableString *description = [NSMutableString string];
    [description appendString:@"<"];
    [description appendString:[super description]];
    [description appendString:[NSString stringWithFormat:@"\n <localizedViolationString: %@>", [self localizedViolationString]]];
    [description appendString:@">"];
    
    return description;
}

@end
