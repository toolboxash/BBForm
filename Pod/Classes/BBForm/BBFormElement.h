//
//  BBFormElement.h
//  catch
//
//  Created by Ashley Thwaites on 14/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class BBFormElement;

@protocol BBFormElementDelegate <UITextFieldDelegate, UITextViewDelegate>

@optional
- (void)formElementDidChangeValue:(BBFormElement *)formElement;
- (void)formElementDidEndEditing:(BBFormElement *)formElement;

@end


@interface BBFormElement : NSObject

// Designated initializer
+ (instancetype)elementWithID:(NSInteger)elementID delegate:(id<BBFormElementDelegate>)delegate;

// leave the validator as id so we are not dependant on the validator headers
@property (nonatomic, retain) id validator;
@property (nonatomic, assign) id<BBFormElementDelegate> delegate;
@property (nonatomic, assign) NSInteger elementID;

@end

