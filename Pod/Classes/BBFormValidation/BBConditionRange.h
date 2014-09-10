
#import <Foundation/Foundation.h>
#import "BBCondition.h"


@interface BBConditionRange : BBCondition
{
@protected
    NSRange _range;
}

@property (nonatomic, assign) NSRange range;


@end
