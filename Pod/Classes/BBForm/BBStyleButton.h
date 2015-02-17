//
//  BBStyleButton.h
//  catch
//
//  Created by Ashley Thwaites on 10/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE

@interface BBStyleButton : UIButton

@property (nonatomic) /*IBInspectable*/ UIColor *borderColor;
@property (nonatomic) /*IBInspectable*/ CGFloat borderWidth;
@property (nonatomic) /*IBInspectable*/ CGFloat cornerRadius;

-(void)setup;

@end
