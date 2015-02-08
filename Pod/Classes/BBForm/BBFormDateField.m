//
//  BBFormDateField.m
//  catch
//
//  Created by Ashley Thwaites on 14/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormDateField.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"
#import "BBExtras-UIView.h"


@implementation BBFormDateFieldElement

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormDateFieldElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.labelText = labelText;
    element.date = date;
    element.originalDate = date;
    element.datePickerMode = datePickerMode;
    element.delegate = delegate;    
    return element;
}

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode datePickerMinDate:(NSDate*)mindate datePickerMaxDate:(NSDate*)maxdate delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormDateFieldElement* element = [self datePickerElementWithID:elementID labelText:labelText date:date datePickerMode:datePickerMode delegate:delegate];
    element.minDate = mindate;
    element.maxDate = maxdate;
    return element;
}

@end



@interface BBFormDateField ()
{
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;
}

@property (nonatomic, readwrite) UITextField *textfield;
@property (nonatomic, readwrite) UILabel *placeholderLabel;
@property (nonatomic, readwrite) UILabel *valueLabel;
@property (nonatomic, readwrite) UIDatePicker *datePicker;

@end

@implementation BBFormDateField

-(void)setup
{
    [super setup];
    
    // create the value label
    _valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _valueLabel.font = [BBStyleSettings sharedInstance].h1Font;
    _valueLabel.textAlignment = NSTextAlignmentRight;
    
    // create a placeholder label.. same content as floating label but different style
    _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _placeholderLabel.font = [BBStyleSettings sharedInstance].h1Font;
    _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    
    // hidden textfield to trigger the datepicker...
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker addTarget:self action:@selector(selectedDateDidChange) forControlEvents:UIControlEventValueChanged];
    
    // we use a hidden textfield to attach the datepicker
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    _textfield.hidden = YES;
    [_textfield setInputView:_datePicker];
    [self addSubview:_textfield];
    
    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    
    // here we should use a defined style not colour..
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[BBStyleSettings sharedInstance] seperatorColor].CGColor;
    
    insideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapInside:)];
    [self addGestureRecognizer:insideTapGestureRecognizer];
    outsideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOutside:)];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;

    [_placeholderLabel removeFromSuperview];
    [_placeholderLabel removeConstraints:_placeholderLabel.constraints];
    [self addSubview:_placeholderLabel];

    [_valueLabel removeFromSuperview];
    [_valueLabel removeConstraints:_valueLabel.constraints];
    [self addSubview:_valueLabel];
    
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_valueLabel])
    {
        [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        [_valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }

    if (![self hasConstraintsForView:_placeholderLabel])
    {
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        [_placeholderLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    
    [super updateConstraints];
}


-(void)dealloc
{
    [self resignFirstResponder];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)updateWithElement:(BBFormDateFieldElement*)element
{
    self.element = element;
    self.placeholder = element.labelText;
    
    _datePicker.datePickerMode = element.datePickerMode;
    _datePicker.minimumDate = element.minDate;
    _datePicker.maximumDate = element.maxDate;

    if (element.date)
        _datePicker.date = element.date;
    [self setDateText];
}

- (void)onTapInside:(UIGestureRecognizer*)sender
{
    [_textfield becomeFirstResponder];
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow addGestureRecognizer:outsideTapGestureRecognizer];
}

- (void)onTapOutside:(UIGestureRecognizer*)sender
{
    [_textfield resignFirstResponder];
    [sender.view removeGestureRecognizer:outsideTapGestureRecognizer];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return [_textfield canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textfield becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow removeGestureRecognizer:outsideTapGestureRecognizer];
    return [_textfield resignFirstResponder];
}


-(void)selectedDateDidChange
{
    // update the value label with formatted date
    [self setDateText];
    _element.date = _datePicker.date;
    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }
}

-(void)setDateText
{
    //    if (self.date == nil)
    //    {
    //        self.valueLabel.text = @" ";
    //        return;
    //    }
    
    if (_element.formatter)
    {
        _valueLabel.text = [_element.formatter stringFromDate:_datePicker.date];
    }
    else
    {
        
        switch (_datePicker.datePickerMode) {
            case UIDatePickerModeDate:
                _valueLabel.text = [NSDateFormatter localizedStringFromDate:_datePicker.date
                                                                  dateStyle:NSDateFormatterShortStyle
                                                                  timeStyle:NSDateFormatterNoStyle];
                break;
                
            case UIDatePickerModeTime:
                _valueLabel.text = [NSDateFormatter localizedStringFromDate:_datePicker.date
                                                                  dateStyle:NSDateFormatterNoStyle
                                                                  timeStyle:NSDateFormatterShortStyle];
                break;
                
            case UIDatePickerModeCountDownTimer:
                if (_datePicker.countDownDuration == 0)
                {
                    _valueLabel.text = NSLocalizedString(@"0 minutes", @"0 minutes");
                } else {
                    int hours = (int)(_datePicker.countDownDuration / 3600);
                    int minutes = (int)((_datePicker.countDownDuration - hours * 3600) / 60);
                    
                    _valueLabel.text = [NSString stringWithFormat:
                                        NSLocalizedString(@"%d hours, %d min",
                                                          @"datepicker countdown hours and minutes"),
                                        hours,
                                        minutes];
                }
                break;
                
            case UIDatePickerModeDateAndTime:
            default:
                _valueLabel.text = [NSDateFormatter localizedStringFromDate:_datePicker.date
                                                                  dateStyle:NSDateFormatterShortStyle
                                                                  timeStyle:NSDateFormatterShortStyle];
                break;
        }
    }
}



-(NSString*)text
{
    return _textfield.text;
}


@end
