
#import "BBConditionRange.h"
#import "BBFormTextField.h"
#import "BBFormSelectField.h"

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
    if (0 == _range.location && 0 == _range.length)
        return YES;
    
    // for select type elements we can check the index
    if ([element isKindOfClass:[BBFormSelectFieldElement class]])
    {
        NSInteger value = ((BBFormSelectFieldElement*)element).index;
        return ((value >= _range.location) && (value <= (_range.location + _range.location)));
    }
    
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
        return NO;

    // for number text entry we can check the numeric is in the range
    if ([element isKindOfClass:[BBFormTextFieldElement class]] &&
        ((BBFormTextFieldElement*)element).inputType == BBTextInputTypeNumber)
    {
        return NSLocationInRange([string integerValue], _range);
    }
    
    // for everything else lets check the length
    return NSLocationInRange(string.length, _range);
}

#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{    
    return  [NSString stringWithFormat:BBLocalizedString(@"BBKeyConditionViolationRange", nil),_range.location,_range.length];
}


@end
