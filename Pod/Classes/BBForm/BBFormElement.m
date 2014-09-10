//
//  BBFormElement.m
//  catch
//
//  Created by Ashley Thwaites on 14/07/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BBFormElement.h"

@implementation BBFormElement

+ (instancetype)elementWithID:(NSInteger)elementID delegate:(id<BBFormElementDelegate>)delegate
{
    BBFormElement *element = [[self class] new];
    element.elementID = elementID;
    element.delegate = delegate;
    return element;
}

@end
