//
//  BBExtras-UIView.m
//  Pods
//
//  Created by Ashley Thwaites on 08/02/2015.
//
//

#import "BBExtras-UIView.h"

@implementation UIView (BBExtras)

- (BOOL)hasConstraintsForView:(UIView*)view;
{
    for (NSLayoutConstraint *constraint in self.constraints)
    {
        if ((constraint.firstItem == view) ||
            (constraint.secondItem == view))
        {
            return YES;
        }
    }
    return NO;
}

@end
