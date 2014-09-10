//
//  BBFloatingLabelSelectField.h
//  whatsup
//
//  Created by Ashley Thwaites on 25/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormSelectField.h"

//IB_DESIGNABLE

@interface BBFloatingLabelSelectField : BBFormSelectField

@property (nonatomic, readonly) UILabel *floatingLabel;
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, readonly) UILabel *valueLabel;

@property (nonatomic) /*IBInspectable*/ NSString *placeholder;

@end
