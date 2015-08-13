

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
    if ([element isKindOfClass:[BBFormTextFieldElement class]])
    {
        NSString *string = ((BBFormTextFieldElement*)element).value;
    
        return [self isStringPresent:string];
    }
    if ([element isKindOfClass:[BBFormTextViewElement class]])
    {
        NSString *string = ((BBFormTextViewElement*)element).value;
        
        return [self isStringPresent:string];
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
            return [self isStringPresent:string];
        }
        
        return NO;
    }
    else if  ([element isKindOfClass:[BBFormAutoCompleteFieldElement class]])
    {
        NSString *string = ((BBFormAutoCompleteFieldElement*)element).value;
        
        if ( ((BBFormAutoCompleteFieldElement*)element).indexRequired)
        {
            NSArray *values = ((BBFormSelectFieldElement*)element).values;
            NSInteger index = ((BBFormSelectFieldElement*)element).index;
            
            string = nil;
            if ((index >=0) && (index < values.count))
            {
                string = values[index];
            }            
        }
                
        return [self isStringPresent:string];
    }
    return NO;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationPresent", nil);
}

@end
