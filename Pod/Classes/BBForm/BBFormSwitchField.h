//
//  BBFormSwitchField.h
//  Pods
//
//  Created by Ash Thwaites on 20/10/2015.
//
//

#import <UIKit/UIKit.h>
#import "BBFormElement.h"
#import "BBStyleView.h"

@interface BBFormSwitchFieldElement : BBFormElement

+ (instancetype)switchFieldElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, assign) BOOL value;
@property (nonatomic, assign) BOOL originalValue;
@property (nonatomic, copy) NSString *labelText;

@end


@interface BBFormSwitchField : BBStyleView

@property (nonatomic, strong) BBFormSwitchFieldElement* element;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, readonly) UILabel *valueLabel;
@property (nonatomic) UIEdgeInsets contentInsets;

-(void)updateWithElement:(BBFormSwitchFieldElement*)element;

@end
