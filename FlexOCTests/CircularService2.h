//
//  CircularService2.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-11.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CircularService1;

@interface CircularService2 : NSObject

@property (nonatomic, retain) CircularService1* service;

@end
