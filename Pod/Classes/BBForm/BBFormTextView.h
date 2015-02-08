//
//  BBFormTextView.h
//  Pods
//
//  Created by Ashley Thwaites on 08/02/2015.
//
//

#import "BBStyleView.h"
#import "BBFormElement.h"

@interface BBFormTextViewElement : BBFormElement

+ (instancetype)textViewElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString* placeholderText;
@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* originalValue;

@end


@interface BBFormTextView : BBStyleView <UITextViewDelegate>

@property (nonatomic, strong) BBFormTextViewElement* element;

@property (nonatomic, readonly) UITextView *textview;
@property (nonatomic) /*IBInspectable*/ NSString *text;
@property (nonatomic) /*IBInspectable*/ NSString *placeholder;
@property (nonatomic) UIEdgeInsets contentInsets;

-(void)updateWithElement:(BBFormTextViewElement*)element;

@end
