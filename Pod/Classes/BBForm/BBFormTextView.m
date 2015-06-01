//
//  BBFormTextView.m
//  Pods
//
//  Created by Ashley Thwaites on 08/02/2015.
//
//

#import "BBFormTextView.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"
#import "BBExtras-UIView.h"



@implementation BBFormTextViewElement


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)textViewElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormTextViewElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.delegate = delegate;
    element.value = value;
    element.placeholderText = placeholderText;
    element.originalValue = value;
    return element;
}

@end


@interface BBFormTextView ()

@end


@implementation BBFormTextView

-(void)setup
{
    [super setup];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _placeholderLabel.font = [BBStyleSettings sharedInstance].h1Font;
    _placeholderLabel.textColor = [[BBStyleSettings sharedInstance] unselectedColor];

    _textview = [[UITextView alloc] initWithFrame:self.bounds];
    _textview.font = [BBStyleSettings sharedInstance].h1Font;
    _textview.delegate = self;
    _textview.textContainerInset = UIEdgeInsetsZero;
    _textview.textContainer.lineFragmentPadding = 0;
    
    self.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // here we should use a defined style not colour..
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[BBStyleSettings sharedInstance] seperatorColor].CGColor;
}


-(void)dealloc
{
    [self resignFirstResponder];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    // remove and readd the views to delete the constraints
    [_textview removeFromSuperview];
    [_textview removeConstraints:_textview.constraints];
    [self addSubview:_textview];

    [_placeholderLabel removeFromSuperview];
    [_placeholderLabel removeConstraints:_placeholderLabel.constraints];
    [self addSubview:_placeholderLabel];
    
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_textview])
    {
        [_textview autoPinEdgesToSuperviewEdgesWithInsets:_contentInsets];
    }
    if (![self hasConstraintsForView:_placeholderLabel])
    {
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:_contentInsets.top];
    }
    [super updateConstraints];
}


-(void)updateWithElement:(BBFormTextViewElement*)element
{
    self.element = element;
    self.text = element.value;
    self.placeholder = element.placeholderText;
    self.placeholderLabel.hidden = (_textview.text.length >0);
}


- (BOOL)canBecomeFirstResponder
{
    return [_textview canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textview becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textview resignFirstResponder];
}

-(void)setText:(NSString *)text
{
    _textview.text = text;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    // call the delegate to inform of value changed
    self.element.value = textView.text;    
    self.placeholderLabel.hidden = (_textview.text.length >0);
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    // call the delegate to inform of value changed
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}



-(NSString*)text
{
    return _textview.text;
}


@end
