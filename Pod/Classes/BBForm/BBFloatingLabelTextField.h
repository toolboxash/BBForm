//
//  BBFloatingLabelTextField.h
//  catch
//
//  Created by Ashley Thwaites on 04/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBStyleView.h"
#import "BBFormTextField.h"

//IB_DESIGNABLE

@interface BBFloatingLabelTextField : BBFormTextField

@property (nonatomic, readonly) UILabel *floatingLabel;

@property (nonatomic) /*IBInspectable*/ NSString *text;
@property (nonatomic) /*IBInspectable*/ NSString *placeholder;

@end
