//
//  BBFormAutoCompleteField.h
//  Pods
//
//  Created by Ash Thwaites on 10/02/2015.
//
//

#import "BBStyleView.h"
#import "BBFormElement.h"

@interface BBFormAutoCompleteFieldElement : BBFormElement

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger originalIndex;
@property (nonatomic, retain) NSArray *values;

@end


@interface BBFormAutoCompleteField : BBStyleView

@property (nonatomic, strong) BBFormAutoCompleteFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic, readonly) UICollectionView *collectionView;

@property (nonatomic) /*IBInspectable*/ NSString *placeholder;
@property (nonatomic) UIEdgeInsets contentInsets;

-(void)updateWithElement:(BBFormAutoCompleteFieldElement*)element;
-(void)textFieldDidChange;

@end
