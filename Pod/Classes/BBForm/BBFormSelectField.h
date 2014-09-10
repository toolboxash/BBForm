//
//  BBFormSelectField.h
//  whatsup
//
//  Created by Ashley Thwaites on 25/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBStyleView.h"
#import "BBFormElement.h"

@interface BBFormSelectFieldElement : BBFormElement

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger originalIndex;
@property (nonatomic, retain) NSArray *values;

@end


@interface BBFormSelectField : BBStyleView <UIPickerViewDataSource, UIPickerViewDelegate >

@property (nonatomic, strong) BBFormSelectFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, readonly) UILabel *valueLabel;
@property (nonatomic, readonly) UIPickerView *pickerView;

@property (nonatomic) /*IBInspectable*/ NSString *placeholder;

-(void)updateWithElement:(BBFormSelectFieldElement*)element;

@end
