//
//  BBStyleSettings.m
//  catch
//
//  Created by Ashley Thwaites on 07/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBStyleSettings.h"
#import "BBExtras-UIColor.h"
#import "BBExtras-UIImage.h"

@implementation BBStyleSettings

+ (BBStyleSettings *)sharedInstance
{
    static dispatch_once_t once;
    static BBStyleSettings *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[BBStyleSettings alloc] init];
    });
    return sharedInstance;
}

// we should consider inheriting from base model.. this way we could configure default style from plist

- (id)init {
    self = [super init];
    if (self) {
        //        _mainColor = [UIColor colorWithHexString:@"#c1c6ca"];
        _h1Font = [UIFont fontWithName:@"Avenir-Roman" size:14];
        _h2Font = [UIFont fontWithName:@"Avenir-Roman" size:12];
        _h3Font = [UIFont fontWithName:@"Avenir-Light" size:12];
        
        _seperatorColor = [UIColor colorWithHexString:@"#eaebed"];                  // 234,235,237
        _selectedColor = [UIColor colorWithHexString:@"#47ecf0"];                   // 71,236,240
        _unselectedColor = [UIColor colorWithHexString:@"#c1c6ca"];                 // 193,198,202
    }
    return self;
}

@end
