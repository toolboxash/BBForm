//
//  BBExtras-UIAlertController.h
//  BackBone
//
//  Created by Ashley Thwaites on 04/02/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class BBConditionCollection;

@interface UIAlertController (BBExtras)

+(UIAlertController*)alertWithTitle:(NSString*)title message:(NSString*)message;
+(UIAlertController*)alertWithMessage:(NSString*)message;
+(UIAlertController*)alertWithConditions:(BBConditionCollection*)conditions;

@end
