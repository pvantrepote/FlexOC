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

-(void) setObjectDefinition:(NSDictionary *)objectDefinition_ {
	if (objectDefinition == objectDefinition_) return;
	
	objectDefinition = nil;
	if (objectDefinition_) {
		NSMutableDictionary* def = [objectDefinition_ mutableCopy];
		[def removeObjectForKey:DictionaryApplicationContextKeywords[ObjectLazy]];
		objectDefinition = def;
	}
}

-(NSObject*) objectInstance {
	if (!super.objectInstance) {
		@synchronized(self) {
			if (!super.objectInstance) {
				super.objectInstance = [context getObjectWithName:objectName 
													andDefinition:objectDefinition];
			}
		}
	}

	return super.objectInstance;
}

#pragma mark - Init/Dealloc

-(id) initWithObjectDefinition:(NSDictionary*) definition_ name:(NSString*) name_ andContext:(id<IApplicationContext>)context_ {
	self = [super init];
	if (self) {
		self.objectDefinition = definition_;
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
