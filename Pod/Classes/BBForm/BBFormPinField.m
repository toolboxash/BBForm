//
//  BBPinField.m
//  BBForm
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormPinField.h"
#import "PureLayout.h"

@implementation BBFormPinFieldElement

+ (id)pinFieldElementWithID:(NSInteger)elementID pinLength:(NSInteger)pinLength delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormPinFieldElement* element = [BBFormPinFieldElement new];
    element.elementID = elementID;
    element.delegate = delegate;
    element.pinLength = pinLength;
    return element;
}

-(NSString*)valueAsString
{
    return self.value;
}

@end

@interface BBFormPinField () <UITextFieldDelegate>
{
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;

    NSArray *dotViews;
}
@property (nonatomic, readwrite) UITextField *textfield;

@end

@implementation BBFormPinField
{
    NSCharacterSet *numberSet;
    NSCharacterSet *noNumberSet;
}

-(void)setup
{
    [super setup];

    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];

    //set up the reject character set
    NSMutableCharacterSet *numSet = [[NSCharacterSet decimalDigitCharacterSet] mutableCopy];
    [numSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    numberSet = numSet;
    noNumberSet = [numberSet invertedSet];

    // setup the dummy text field
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    _textfield.hidden = YES;
    _textfield.delegate = self;
    _textfield.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_textfield];
    
    insideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapInside:)];
    [self addGestureRecognizer:insideTapGestureRecognizer];
    outsideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOutside:)];
}

-(void)dealloc
{
    [outsideTapGestureRecognizer.view removeGestureRecognizer:outsideTapGestureRecognizer];
    [insideTapGestureRecognizer.view removeGestureRecognizer:insideTapGestureRecognizer];
}

// override this to support createing subclassed dots
-(BBFormPinDot*)createDotWithTag:(NSInteger)tag
{
    BBFormPinDot *dot = [BBFormPinDot new];
    dot.tag = tag;
    return dot;
}

-(void)updateWithElement:(BBFormPinFieldElement*)element
{
    self.element = element;
    
    for (BBFormPinDot *dot in dotViews)
    {
        [dot removeFromSuperview];
    }
    dotViews = nil;
    
    if (element.pinLength >0)
    {
        NSMutableArray *dots = [NSMutableArray arrayWithCapacity:element.pinLength];
        for (int i=0;i < element.pinLength; i++)
        {
            BBFormPinDot *dot = [self createDotWithTag:i];
            [dots addObject:dot];
            [self addSubview:dot];
        }
        
        [dots[0] autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        [dots autoSetViewsDimension:ALDimensionHeight toSize:22];
        [dots autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeTop withFixedSize:22];
        dotViews = dots;
    }
    _textfield.text = element.value;
    // setup
    // create the pin cells
}

- (void)onTapInside:(UIGestureRecognizer*)sender
{
    [_textfield becomeFirstResponder];
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow addGestureRecognizer:outsideTapGestureRecognizer];
}

- (void)onTapOutside:(UIGestureRecognizer*)sender
{
    [_textfield resignFirstResponder];
    [sender.view removeGestureRecognizer:outsideTapGestureRecognizer];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return [_textfield canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textfield becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow removeGestureRecognizer:outsideTapGestureRecognizer];
    return [_textfield resignFirstResponder];
}


-(void)updateBoxesForLength:(NSInteger)length
{
    for (BBFormPinDot *pinDot in dotViews)
    {
        if (pinDot.tag < length)
        {
            pinDot.state = BBPinDotStateSelected;
        }
        else if (((_textfield.isEditing) && pinDot.tag == length))
        {
            pinDot.state = BBPinDotStateHighlighted;
        }
        else
        {
            pinDot.state = BBPinDotStateUnselected;
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self updateBoxesForLength:textField.text.length];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO; //default to reject
    
    if([string length] == 0)
    { //backspace
        result = YES;
    }
    else{
        if([string stringByTrimmingCharactersInSet:noNumberSet].length > 0)
        {
            result = YES;
        }
    }
    
    //here we deal with the UITextField on our own
    if(result)
    {
        NSMutableString* mstring = [[textField text] mutableCopy];
        
        //adding a char or deleting?
        if([string length] > 0)
        {
            [mstring insertString:string atIndex:range.location];
        }
        else {
            //delete case - the length of replacement string is zero for a delete
            [mstring deleteCharactersInRange:range];
        }
        
        if (mstring.length > self.element.pinLength)
        {
            [textField setText:[mstring substringWithRange:NSMakeRange(0, self.element.pinLength)]];
        }
        else
        {
            [textField setText:mstring];
        }
        
        [self updateBoxesForLength:mstring.length];
        
        self.element.value = mstring;
        
        if (mstring.length == self.element.pinLength)
        {
            if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
            {
                [(id<BBFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
            }
        }
    }
    
    return NO;
}


@end
