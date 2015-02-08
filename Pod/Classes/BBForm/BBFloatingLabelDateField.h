//
//  BBDateField.h
//  catch
//
//  Created by Ashley Thwaites on 08/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormDateField.h"

//IB_DESIGNABLE

@interface BBFloatingLabelDateField : BBFormDateField

@property (nonatomic, readonly) UILabel *floatingLabel;
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, readonly) UILabel *valueLabel;

@property (nonatomic) /*IBInspectable*/ NSString *placeholder;
@property (nonatomic) /*IBInspectable*/ NSInteger datePickerMode;

@end
