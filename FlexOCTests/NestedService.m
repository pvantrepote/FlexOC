//
//  NestedService.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-25.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "NestedService.h"

@implementation NestedService

@synthesize service;

- (void)dealloc {
    self.service = nil;
}

@end
