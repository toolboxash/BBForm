//
//  BBProtocolInterceptor.h
//  Somo-skrill-demo
//
//  Created by Ashley Thwaites on 08/11/2013.
//  Copyright (c) 2013 Somo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBProtocolInterceptor : NSObject

@property (nonatomic, readonly, copy) NSArray * interceptedProtocols;
@property (nonatomic, weak) id receiver;
@property (nonatomic, weak) id middleMan;

- (instancetype)initWithInterceptedProtocol:(Protocol *)interceptedProtocol;
- (instancetype)initWithInterceptedProtocols:(Protocol *)firstInterceptedProtocol, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithArrayOfInterceptedProtocols:(NSArray *)arrayOfInterceptedProtocols;

@end
