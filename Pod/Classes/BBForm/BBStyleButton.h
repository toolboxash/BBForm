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
@property (nonatomic) /*IBInspectable*/ NSInteger borderWidth;
@property (nonatomic) /*IBInspectable*/ NSInteger cornerRadius;

-(void)setup;

@end
