//
//  ObjectDefinition.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ObjectDefinition.h"

@implementation ObjectDefinition

#pragma mark - Properties

@synthesize name, type, isSingleton, isLazy, factory, initializer, properties;

#pragma mark - Init/Dealloc

-(void)dealloc {
	self.name = nil;
	self.type = nil;
	self.factory = nil;
	self.properties = nil;
	self.initializer = nil;
}

@end
