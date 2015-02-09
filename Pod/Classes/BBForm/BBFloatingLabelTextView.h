//
//  BBFloatingLabelTextView.h
//  Pods
//
//  Created by Ashley Thwaites on 08/02/2015.
//
//

#import "BBFormTextView.h"

@interface BBFloatingLabelTextView : BBFormTextView

@property (nonatomic) CGFloat floatingLabelOffset;
@property (nonatomic, readonly) UILabel *floatingLabel;

@end
