//
//  BBFormAutoCompleteField.m
//  Pods
//
//  Created by Ash Thwaites on 10/02/2015.
//
//

#import "BBFormAutoCompleteField.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"
#import "BBExtras-UIView.h"

@interface BBAutoCompleteCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *separatorView;

@end;

@implementation BBAutoCompleteCell

-(id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [BBStyleSettings sharedInstance].unselectedColor;
        
        float sortaPixel = 1.0/[UIScreen mainScreen].scale;
        _separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sortaPixel, self.frame.size.height)];        
        _separatorView.userInteractionEnabled = NO;
        [_separatorView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_separatorView];
        
        // add the label, and the constraints to center it and margins to either side
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.font = [BBStyleSettings sharedInstance].h1Font;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
        [_label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:4];
        [_label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:4];
        [_label autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    return self;
}

@end


@implementation BBFormAutoCompleteFieldElement

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormAutoCompleteFieldElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.values = values;
    element.index = -1;
    element.originalIndex = -1;
    return element;
}

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormAutoCompleteFieldElement *element = [self selectElementWithID:elementID labelText:labelText values:values delegate:delegate];
    element.index = index;
    element.originalIndex = index;
    return element;
}

@end


@interface BBFormAutoCompleteField () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;
    NSArray *autoCompleteSuggestions;
}

@property (nonatomic, readwrite) UITextField *textfield;
@property (nonatomic, readwrite) UICollectionView *collectionView;

@end


@implementation BBFormAutoCompleteField

-(void)setup
{
    [super setup];
    
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    [_textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _textfield.font = [BBStyleSettings sharedInstance].h1Font;
    _textfield.delegate = self;
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 44) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[BBAutoCompleteCell class] forCellWithReuseIdentifier:@"BBAutoCompleteCell"];

    _collectionView.backgroundColor = [BBStyleSettings sharedInstance].unselectedColor;
    _textfield.inputAccessoryView = _collectionView;
    
    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    
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
    [self.textfield removeFromSuperview];
    [self.textfield removeConstraints:self.textfield.constraints];
    [self addSubview:self.textfield];
    
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_textfield])
    {
        [_textfield autoPinEdgesToSuperviewEdgesWithInsets:_contentInsets];
    }
    
    [super updateConstraints];
}


-(void)updateWithElement:(BBFormAutoCompleteFieldElement*)element
{
    self.element = element;
    self.placeholder = element.labelText;
    if ((element.index >=0) && (element.index < element.values.count))
        _textfield.text = [self.element.values objectAtIndex:element.index];
    else
        _textfield.text = element.value;
    _textfield.keyboardType = UIKeyboardTypeDefault;
    _textfield.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self updateSuggestions];
    [_collectionView reloadData];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [_textfield setPlaceholder:placeholder];
    [self setNeedsLayout];
    [self layoutIfNeeded];
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
    return [_textfield resignFirstResponder];
}

-(void)updateSuggestions
{
    NSPredicate *suggestPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@", _textfield.text];
    autoCompleteSuggestions = [self.element.values filteredArrayUsingPredicate:suggestPredicate];
    
    if ((_textfield.text.length == 0) && self.element.displayAllWhenBlank)
        autoCompleteSuggestions = self.element.values;
}

-(void)updateIndex
{
    NSPredicate *matchPredicate = [NSPredicate predicateWithFormat:@"self ==[c] %@", _textfield.text];
    self.element.index = [self.element.values  indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return [matchPredicate evaluateWithObject:obj];
    }];
    
    if (self.element.index == NSNotFound)//check this condition for the max integer value
    {
        self.element.index = -1;
    }
    self.element.value = _textfield.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange {
    // for now dont bother with another thread, or operstiaon queue
    [self updateSuggestions];
    [self updateIndex];
    [_collectionView reloadData];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // call the delegate to inform of value changed
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
    if (((self.element.index >=0) && (self.element.index < self.element.values.count)) || (_textfield.text.length == 0)  || self.element.index < 0)
        return YES;
    return NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (autoCompleteSuggestions)
        return autoCompleteSuggestions.count;
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BBAutoCompleteCell *cell = (BBAutoCompleteCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"BBAutoCompleteCell" forIndexPath:indexPath];
    cell.label.text = autoCompleteSuggestions[indexPath.row];
    cell.label.font = self.textfield.font;
    cell.separatorView.hidden = (indexPath.row==0);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // we know the font we are using, so calc the width of the font
    NSString *suggestion = autoCompleteSuggestions[indexPath.row];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.textfield.font, NSFontAttributeName, nil];
    CGSize suggestionSize = [suggestion sizeWithAttributes:attributes];
    return CGSizeMake(suggestionSize.width + 10, 44);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    _textfield.text = autoCompleteSuggestions[indexPath.row];
    [self updateIndex];
    if (self.element.index <0)
    {
        // wtf ?
        self.element.index = [self.element.values  indexOfObject:autoCompleteSuggestions[indexPath.row]];
    }

    [_textfield resignFirstResponder];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

@end
