//
//  BBStyleSettings.h
//  catch
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBStyleSettings : NSObject

+ (BBStyleSettings *)sharedInstance;

@property (strong, readwrite) UIFont *h1Font;
@property (strong, readwrite) UIFont *h2Font;
@property (strong, readwrite) UIFont *h3Font;

@property (strong, readwrite) UIColor *seperatorColor;

// something that can be clicked
@property (strong, readwrite) UIColor *selectedColor;
@property (strong, readwrite) UIColor *unselectedColor;
@property (strong, readwrite) UIColor *backgroundColor;

@end
