
#import "BBConditionRange.h"
#import "BBFormTextField.h"

@implementation BBConditionRange


@synthesize range = _range;


- (id)init
{
    self = [super init];
    if (self)
    {
        _range = NSMakeRange(0, 0);
    }
    
    return self;
}


#pragma mark - Violation check

- (BOOL)check:(BBFormElement *)element;
{
    if (![element isKindOfClass:[BBFormTextFieldElement class]])
        return NO;
    NSString *string = ((BBFormTextFieldElement*)element).value;
    
    BOOL success = NO;
    
    if (0 == _range.location
        && 0 == _range.length)
        success = YES;
    
    if (nil == string)
        string = [NSString string];
    
    if(string.length >= _range.location && string.length <= _range.length)
    {
        success = YES;
    }
    
    return success;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{    
    return  [NSString stringWithFormat:BBLocalizedString(@"BBKeyConditionViolationRange", nil),_range.location,_range.length];
}


@end
