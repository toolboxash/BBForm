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
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *placeholder;

@end
