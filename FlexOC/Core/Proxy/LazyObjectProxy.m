//
//  LazyObjectProxy.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-01.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "LazyObjectProxy.h"

#import "IApplicationContext.h"
#import "DictionaryApplicationContext.h"

@implementation LazyObjectProxy

#pragma mark - Properties

@synthesize objectDefinition, context, objectName;

-(NSObject*) target {
	if (!super.target) {
		@synchronized(self) {
			if (!super.target) {
				objectDefinition.isLazy = NO;
				super.target = [context getObjectWithName:objectName 
											andDefinition:objectDefinition];
				objectDefinition.isLazy = YES;
			}
		}
	}

	return super.target;
}

#pragma mark - Init/Dealloc

-(id) initWithObjectDefinition:(id<IObjectDefinition>) objectDefinition_ name:(NSString*) name_ andContext:(id<IApplicationContext>)context_ {
	self = [super init];
	if (self) {
		self.objectDefinition = objectDefinition_;
		self.context = context_;
		self.objectName = name_;
	}
	
	return self;
}

- (void)dealloc {
	self.objectDefinition = nil;
	self.context = nil;
	self.objectName = nil;
}

@end
