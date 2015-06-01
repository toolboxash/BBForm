//
//  BBPinField.h
//  BBForm
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFormElement.h"
#import "BBStyleView.h"

@interface BBFormPinFieldElement : BBFormElement

+ (instancetype)pinFieldElementWithID:(NSInteger)elementID pinLength:(NSInteger)pinLength delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, assign) NSInteger pinLength;
@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* originalValue;

@end


@interface BBFormPinField : BBStyleView

@property (nonatomic, strong) BBFormPinFieldElement* element;
@property (nonatomic, readonly) UITextField *textfield;

-(void)updateWithElement:(BBFormPinFieldElement*)element;

@end
