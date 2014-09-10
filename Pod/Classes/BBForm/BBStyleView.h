//
//  BBStyleView.h
//  catch
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>

// would be agood to add some categories to UIVIew, UILabel etc that support a style name field so we can set "h1Font" in interfacebuilder

//IB_DESIGNABLE

@interface BBStyleView : UIView

@property (nonatomic) /*IBInspectable*/ UIColor *borderColor;
@property (nonatomic) /*IBInspectable*/ NSInteger borderWidth;
@property (nonatomic) /*IBInspectable*/ NSInteger cornerRadius;

-(void)setup;

@end
