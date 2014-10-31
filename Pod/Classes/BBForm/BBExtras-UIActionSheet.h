//
//  BBExtras-UIActionSheet.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/03/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIActionSheet (BBExtras) <UIActionSheetDelegate>


- (id)initWithTitle:(NSString *)title completionBlock:(void (^)(NSUInteger buttonIndex))block cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
