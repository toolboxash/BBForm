//
//  BBFormDateField.h
//  catch
//
//  Created by Ashley Thwaites on 14/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBStyleView.h"
#import "BBFormElement.h"

@interface BBFormDateFieldElement : BBFormElement

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode delegate:(id<BBFormElementDelegate>)delegate;
+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode datePickerMinDate:(NSDate*)mindate datePickerMaxDate:(NSDate*)maxdate delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *originalDate;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, retain) NSDate *minDate;
@property (nonatomic, retain) NSDate *maxDate;
@property (nonatomic, retain) NSDateFormatter *formatter;

@end



@interface BBFormDateField : BBStyleView

@property (nonatomic, strong) BBFormDateFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, readonly) UILabel *valueLabel;
@property (nonatomic, readonly) UIDatePicker *datePicker;

@property (nonatomic) /*IBInspectable*/ NSString *placeholder;

-(void)selectedDateDidChange;
-(void)updateWithElement:(BBFormDateFieldElement*)element;

@end
