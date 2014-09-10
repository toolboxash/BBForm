//
//  BBConditionMatchElement.h
//  monit
//
//  Created by Ashley Thwaites on 23/10/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBCondition.h"

@interface BBConditionMatchElement : BBCondition

@property (strong, nonatomic) BBFormElement *matchElement;

- (id)initWithMatchElement:(BBFormElement *)matchElement;

@end
