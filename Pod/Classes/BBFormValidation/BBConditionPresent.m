

#import "BBConditionPresent.h"
#import "BBFormTextField.h"
#import "BBFormDateField.h"
#import "BBFormSelectField.h"
#import "BBFormAutoCompleteField.h"
#import "BBFormTextView.h"

//#import "BBMultiSelectListFormElement.h"

@implementation BBConditionPresent

- (BOOL)check:(BBFormElement *)element;
{
    if ([element isKindOfClass:[BBFormTextFieldElement class]])
    {
        NSString *string = ((BBFormTextFieldElement*)element).value;
    
        if(!string)
        {
            return NO;
        }
        return string.length > 0 ? YES : NO;
    }
    if ([element isKindOfClass:[BBFormTextViewElement class]])
    {
        NSString *string = ((BBFormTextViewElement*)element).value;
        
        if(!string)
        {
            return NO;
        }
        return string.length > 0 ? YES : NO;
    }
    else if  ([element isKindOfClass:[BBFormDateFieldElement class]])
    {
        NSDate *date = ((BBFormDateFieldElement*)element).date;
        
        if(date != nil)
        {
            return YES;
        }        
    }
    else if  ([element isKindOfClass:[BBFormSelectFieldElement class]])
    {
        NSArray *values = ((BBFormSelectFieldElement*)element).values;
        NSInteger index = ((BBFormSelectFieldElement*)element).index;
        
        if ((index >=0) && (index < values.count))
        {
            NSString *string = values[index];
            return string.length > 0 ? YES : NO;
        }
        
        return NO;
    }
    else if  ([element isKindOfClass:[BBFormAutoCompleteFieldElement class]])
    {
        NSArray *values = ((BBFormAutoCompleteFieldElement*)element).values;
        NSInteger index = ((BBFormAutoCompleteFieldElement*)element).index;
        
        if ((index >=0) && (index < values.count))
        {
            NSString *string = values[index];
            return string.length > 0 ? YES : NO;
        }
        
        return NO;
    }
    return NO;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationPresent", nil);
}

@end
