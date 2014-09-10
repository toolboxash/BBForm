//
//  BBNibCache.m
//
//  Created by Ashley Thwaites on 07/03/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBNibCache.h"

@interface BBNibCache ()

@property (nonatomic, strong) NSMutableDictionary *cacheDictionary;

@end


@implementation BBNibCache


+ (BBNibCache *)sharedCache {
    static BBNibCache *_instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,
                  ^{
                      _instance = [[self alloc] init];
                      _instance.cacheDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
                  });
    
    return _instance;
}

-(UINib*)nibWithName:(NSString*)nibName;
{
    UINib *nib = [self.cacheDictionary valueForKey:nibName];
    if (nib == nil)
    {
        nib = [UINib nibWithNibName:nibName bundle:nil];
        if (nib)
        {
            [self.cacheDictionary setObject:nib forKey:nibName];
        }
    }
    return nib;
}

@end
