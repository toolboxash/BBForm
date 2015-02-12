//
//  BBFloatingLabelAutoCompleteField.h
//  Pods
//
//  Created by Ash Thwaites on 10/02/2015.
//
//

#import "BBFormAutoCompleteField.h"

@interface BBFloatingLabelAutoCompleteField : BBFormAutoCompleteField

@property (nonatomic, readonly) UILabel *floatingLabel;
@property (nonatomic) /*IBInspectable*/ NSString *text;
@property (nonatomic) /*IBInspectable*/ NSString *placeholder;

@end
