//
//  ObjectValueDefinition.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-22.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ObjectValueDefinition.h"

@implementation ObjectValueDefinition

#pragma mark - Properties

@synthesize type, value;

#pragma mark - Init/Dealloc

-(void)dealloc {
	self.value = nil;
}

@end
