//
//  DependencyTree.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "DependencyTree.h"

#define DAC_APPCTX_TLS	@"DepTreeTLS"

@interface DependencyTree (Private)

-(id) initWithObjectName:(NSString*) objectName andInstance:(id) instance_;
-(void) addChild:(DependencyTree*) child;
-(void) removeChild:(DependencyTree*) child;

@end

@implementation DependencyTree

#pragma mark - Properties

@synthesize parent, name, instance;

#pragma mark - Init/Dealloc

-(id)init {
	self = [super init];
	if (self) {
		children = [NSMutableArray array];
	}
	
	return self;
}

-(void)dealloc {
	children = nil;
	name = nil;
	instance = nil;
	parent = nil;
}

#pragma mark - Public methods

+(id) hasCircularDependencyForObjectName:(NSString*) objectName {
	
	NSMutableDictionary* tls = [[NSThread currentThread] threadDictionary];
	
	DependencyTree* currentNode = (DependencyTree*)[tls objectForKey:DAC_APPCTX_TLS];
	if (!currentNode) return nil;

	/// Check if one of my parent in the branch is me (just check by name, its supposed to be unique)
	DependencyTree* node = currentNode;
	while (node) {
		if ([node.name isEqualToString:objectName]) {
			return node.instance;
		}
		
		node = node.parent;
	}
	
	return nil;
}

+(void) pushInstance:(id) instance forObjectName:(NSString*) objectName {
	NSMutableDictionary* tls = [[NSThread currentThread] threadDictionary];

	DependencyTree* node = [[DependencyTree alloc] initWithObjectName:objectName 
														  andInstance:instance];

	DependencyTree* currentNode = (DependencyTree*)[tls objectForKey:DAC_APPCTX_TLS];
	if (currentNode) {
		[currentNode addChild:node];
	}
	
	[tls setObject:node 
			forKey:DAC_APPCTX_TLS];
}

+(void) pop {
	NSMutableDictionary* tls = [[NSThread currentThread] threadDictionary];

	DependencyTree* currentNode = (DependencyTree*)[tls objectForKey:DAC_APPCTX_TLS];
	if (!currentNode) return;
	
	DependencyTree* parent = currentNode.parent;
	if (parent) {
		[parent removeChild:currentNode];
		
		[tls setObject:parent 
				forKey:DAC_APPCTX_TLS];
	}
	else {
		[tls removeObjectForKey:DAC_APPCTX_TLS];
	}

}

@end

@implementation DependencyTree (Private)

-(id) initWithObjectName:(NSString*) objectName andInstance:(id) instance_ {
	self = [self init];
	if (self) {
		name = objectName;
		self.instance = instance_;
	}
	
	return self;
}

-(void) addChild:(DependencyTree*) child {
	[children addObject:child];
	child.parent = self;
}

-(void) removeChild:(DependencyTree*) child {
	[children removeObject:child];
	child.parent = nil;
}

@end
