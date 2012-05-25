//
//  ApplicationContext.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ApplicationContext.h"

#import "IObjectDefinition.h"
#import "IObjectInitDefinition.h"
#import "IObjectFactoryDefinition.h"
#import "IObjectValueDefinition.h"
#import "DependencyTree.h"
#import "LazyObjectProxy.h"
#import "DictionaryCache.h"
#import "IApplicationContextAware.h"
#import "IObjectNameAware.h"

@interface ApplicationContext (Private) <CacheDelegate>

-(id) createObject:(NSString*) objectName withDefinition:(id<IObjectDefinition>) objectDefinition;
-(BOOL) configureObject:(NSObject* )object withName:(NSString *)objectName andDefinition:(id<IObjectDefinition>) objectDefinition;
-(id) getValue:(id<IObjectValueDefinition>) value;

@end

@implementation ApplicationContext

#pragma mark - Properties

@synthesize objects = objectsCfg, allowCircularDependencies;

-(void) setCache:(id<ICache>)cache {
	if (singletons == cache) return;
	
	if (cache) {
		singletons = cache;
		singletons.delegate = self;
	}
	else {
		singletons.delegate = nil;
		singletons = nil;
	}
}

#pragma mark - Init/Dealloc

-(id)init {
	self = [super init];
	if (self) {
		objectsCfg = [NSMutableDictionary dictionary];
		
		/// Check if the user setup a cache
		if (!singletons) {
			self.cache = [[DictionaryCache alloc] init];
		}
	}
	
	return self;
}

- (void)dealloc {
	objectsCfg = nil;
}

#pragma mark - Public methods

-(void)addObject:(NSString *)objectName withDefinition:(id<IObjectDefinition>)objectDefinition {
	[objectsCfg setObject:objectDefinition forKey:objectName];
}

-(void) mergeWithContext:(id<IApplicationContext>) applicationContext {
	if (![applicationContext isKindOfClass:[ApplicationContext class]]) 
		return;
	
	ApplicationContext* srcCtx = (ApplicationContext*) applicationContext;
	
	[objectsCfg addEntriesFromDictionary:srcCtx.objects];
}

-(BOOL) configureObject:(NSObject*) objectInstance withName:(NSString*) objectName {
	id<IObjectDefinition> objectDefinition = [objectsCfg objectForKey:objectName];
	if (!objectDefinition) {
		return NO;
	}
	
	return [self configureObject:objectInstance 
						withName:objectName 
				   andDefinition:objectDefinition];
}

-(id) getObjectWithName:(NSString*) objectName andDefinition:(id<IObjectDefinition>) objectDefinition {
	if (!objectDefinition) return nil;
	
	/// No name has been specified, generate one from the hash of the definition
	if (!objectName) {
		objectName = [NSString stringWithFormat:@"%d", objectDefinition.hash];
	}
	
	/// First we check if the object already exists in the context to avoid circular dependency
	id instance = [DependencyTree hasCircularDependencyForObjectName:objectName];
	if (instance) {
		return (!allowCircularDependencies) ? nil : instance;
	}
	
	/// Check if its a singleton
	__strong id objectInstance = nil;
	if (objectDefinition.isSingleton) {
		/// Its a singleton, get it from the cache
		objectInstance = [singletons elementForKey:objectName];
	}
	else {
		/// Just create a new instance
		objectInstance = [self createObject:objectName 
							 withDefinition:objectDefinition];
	}
	
	return objectInstance;
}

-(id) getObjectWithName:(NSString *)objectName {
	if (!objectsCfg) return nil;
	
	id<IObjectDefinition> objectDefinition = [objectsCfg objectForKey:objectName];
	if (!objectDefinition) return nil;
	
	return [self getObjectWithName:objectName 
					 andDefinition:objectDefinition];
}

@end

@implementation ApplicationContext (Private)

-(id) createObject:(NSString*) objectName withDefinition:(id<IObjectDefinition>) objectDefinition {
	if (!objectDefinition.type) return nil;
	
	/// Get the class type for the definition
	Class c = NSClassFromString(objectDefinition.type);
	if (!c) return nil;
	
	BOOL initialized = NO;
	NSObject* objectInstance = nil;
	
	/// Check if its a lazy object
	if (objectDefinition.isLazy) {
		objectInstance = [[LazyObjectProxy alloc] initWithObjectDefinition:objectDefinition 
																	  name:objectName
																andContext:self];
		initialized = YES;
	}
	else {
		if (objectDefinition.factory) {
			/// Get the selector from the factory methos
			SEL factoryMethodSelector = NSSelectorFromString(objectDefinition.factory.factoryMethod);
			NSInvocation* invocation = nil;
			id target;
			
			if (!objectDefinition.factory.factoryObject) {
				/// Create the invocation instance
				NSMethodSignature* signature = [c methodSignatureForSelector:factoryMethodSelector];
				if (!signature) return nil;
				
				invocation = [NSInvocation invocationWithMethodSignature:signature];
				target = c;
			}
			else {
				/// We have a factory object, to get the class type
				Class objectFactory = NSClassFromString(objectDefinition.factory.factoryObject);
				if (!objectFactory) {
					return nil;
				}
				
				/// And now create the invocation instance.
				/// The target will be the factory object
				NSMethodSignature* signature = [objectFactory methodSignatureForSelector:factoryMethodSelector];
				if (!signature) return nil;
				
				invocation = [NSInvocation invocationWithMethodSignature:signature];
				target = objectFactory;
			}
			
			/// Set and invoke the target
			invocation.selector = factoryMethodSelector;
			[invocation invokeWithTarget:target];
			
			/// Get the returned object
			__unsafe_unretained NSObject* returnedObject = nil;
			[invocation getReturnValue:&returnedObject];
			objectInstance = returnedObject;
			
			/// Init is done
			initialized = YES;
		}
		else {
			/// Alloc the object instance
			objectInstance = [c alloc];
		}		
	}
	
	/// Add to the context
	[DependencyTree pushInstance:objectInstance 
				   forObjectName:objectName];
	
	if (!initialized) {
		/// Initialization
		id<IObjectInitDefinition> initDefinition = objectDefinition.initializer;
		if (initDefinition) {
			SEL selector;
			if (initDefinition.selector) {
				/// Get the selector from the init definition
				selector = NSSelectorFromString(initDefinition.selector);
			}
			
			if (selector) {
				NSMethodSignature* signature = [objectInstance methodSignatureForSelector:selector];
				if (!signature) {
					[DependencyTree pop];
					return nil;
				}
				
				NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
				
				NSArray* arguments = initDefinition.arguments;
				NSInteger argumentIndex = 2;
				for (id<IObjectValueDefinition> argument in arguments) {
					id value = [self getValue:argument];
					[invocation setArgument:(void*)&value 
									atIndex:argumentIndex];
					
					argumentIndex++;
				}
				
				invocation.selector = selector;
				[invocation invokeWithTarget:objectInstance];
				[invocation getReturnValue:&objectInstance];
				
				initialized = YES;
			}
		}
		
		if (!initialized) {
			/// not initialized yet, so do it please :)
			objectInstance = [objectInstance init];
		}
	}
	
	if (objectInstance && !objectDefinition.isLazy) {
		/// Setup the object if its not a lazy one
		BOOL configured = [self configureObject:objectInstance 
									   withName:objectName 
								  andDefinition:objectDefinition];
		if (!configured) {
			objectInstance = nil;			
		}
	}
	
	[DependencyTree pop];
	
	return objectInstance;
}

-(BOOL) configureObject:(NSObject* )objectInstance withName:(NSString *)objectName andDefinition:(id<IObjectDefinition>) objectDefinition {
	
	/// Assign the context of the instance is comform to IApplicationContextAware
	if ([objectInstance conformsToProtocol:@protocol(IApplicationContextAware)]) {
		((id<IApplicationContextAware>)objectInstance).context = self;
	}
	
	/// Assign the name of the instance is comform to IObjectNameAware
	if ([objectInstance conformsToProtocol:@protocol(IObjectNameAware)]) {
		((id<IObjectNameAware>)objectInstance).name = objectName;
	}			

	NSMutableDictionary* properties = objectDefinition.properties;
	if (!properties || ![properties count]) {
		/// Nothing to do, just return YES
		return YES;
	}
		
	/// Assign all properties
	NSMutableDictionary* keyValues = [NSMutableDictionary dictionary];
	for (NSString* key in [properties allKeys]) {
		id<IObjectValueDefinition> value = [self getValue:[properties objectForKey:key]];
		if (value) {
			[keyValues setObject:value  
						  forKey:key];			
		}
	}
	
	[objectInstance setValuesForKeysWithDictionary:keyValues];
	
	return YES;
}

-(id) getValue:(id<IObjectValueDefinition>) valueDefinition {
	if (!valueDefinition) return nil;
	
	id result = nil;
	
	switch (valueDefinition.type) {
		default:
		case ObjectValueTypeValue: 
			result = valueDefinition.value;
			break;
		case ObjectValueTypeReference: 
			result = [self getObjectWithName:(NSString*)valueDefinition.value];
			break;
		case ObjectValueTypeObject:
			result = [self createObject:[NSString stringWithFormat:@"%d", valueDefinition.hash]  
						 withDefinition:(id<IObjectDefinition>)valueDefinition.value];
			break;
		case ObjectValueTypeList: {
			NSArray* cfg = (NSArray*) valueDefinition.value;
			NSMutableArray* values = [NSMutableArray array];
			for (id val in cfg) {
				id value = [self getValue:val];
				if (!value) return nil;
				[values addObject:value];
			}
			
			result = values;
		}
			break;
		case ObjectValueTypeDictionary: {
			NSDictionary* cfg = (NSDictionary*) valueDefinition.value;
			NSMutableDictionary* values = [NSMutableDictionary dictionary];
			for (NSString* key in cfg) {
				id value = [self getValue:[cfg objectForKey:key]];
				if (!value) return nil;
				[values setObject:value 
						  forKey:key];
			}
			
			result = values;
		}
			break;
	}

	return result;
}

-(id) cache:(id<ICache>)cache requestInstanceForKey:(NSString*) objectName {
	/// Get the object configuration
	id<IObjectDefinition> objectDefinition = [objectsCfg objectForKey:objectName];
	if (!objectDefinition) return nil;
	
	return [self createObject:objectName 
			   withDefinition:objectDefinition];
}

-(BOOL) cacheShouldRemoveAllElements:(id<ICache>)cache {
	return YES;
}

@end
