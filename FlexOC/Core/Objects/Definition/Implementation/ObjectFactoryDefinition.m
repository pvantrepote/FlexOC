//
//  ObjectFactoryDefinition.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ObjectFactoryDefinition.h"

@implementation ObjectFactoryDefinition

#pragma mark - Properties

@synthesize factoryMethod, factoryObject;

#pragma mark - Init/Dealloc

-(void) dealloc {
	self.factoryMethod = nil;
	self.factoryObject = nil;
}

@end
