//
//  ObjectInitDefinition.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-21.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ObjectInitDefinition.h"

@implementation ObjectInitDefinition

#pragma mark - Properties

@synthesize selector, arguments;

#pragma mark - Init/Dealloc

-(id) init {
	self = [super init];
	if (self) {
		arguments = [NSMutableArray array];
	}
	
	return self;
}

-(void) dealloc {
	self.selector = nil;
	self.arguments = nil;
}

@end
