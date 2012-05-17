//
//  DictionaryApplicationContext.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "DictionaryApplicationContext.h"

#import "IApplicationContext.h"
#import "DictionaryCache.h"
#import "ApplicationContextResourceProvider.h"
#import "LazyObjectProxy.h"
#import "DependencyTree.h"

const NSString* DictionaryApplicationContextKeywords[] = { 
	@"flexoccontext",
	@"includes",
	@"allowCircularDependencies",
	@"objects",
	@"resources",
	@"type", 
	@"singleton",
	@"lazy",
	@"properties",
	@"ref",
	@"value",
	@"object",
	@"dictionary",
	@"factory-method",
	@"factory-object",
	@"init",
	@"selector",
	@"arguments"};

@interface DictionaryApplicationContext (Private) <CacheDelegate>

-(id) createObject:(NSString*) objectName withConfiguration:(NSDictionary*) objectConfiguration;
-(BOOL) configureObject:(NSObject* )object withName:(const NSString *)objectName andConfiguration:(NSDictionary*) cfg;
-(id) getValue:(id) cfgValue;
-(void) setResources:(NSDictionary*) resources;

@end

@interface DictionaryApplicationContext ()

@property (nonatomic, retain) NSDictionary* objects;
@property (nonatomic, retain) id<ICache> cache;

@end

@implementation DictionaryApplicationContext

#pragma mark - Properties

@synthesize objects = objectsCfg, allowCircularDependencies, cache = singletons;

-(void) setObjects:(NSDictionary *)objectsCfg_ {
	if (objectsCfg == objectsCfg_) return;
	
	if (objectsCfg_) {
		[objectsCfg addEntriesFromDictionary:objectsCfg_];
	}
	else {
		objectsCfg = nil;
	}
}

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

-(id) initWithDictionary:(NSDictionary *)configuration {
	self = [super init];
	if (self) {
		NSDictionary* context = [configuration objectForKey:DictionaryApplicationContextKeywords[ApplicationContextKey]];
		if (!context) {
			return nil;
		}
		
		///
		allowCircularDependencies = [[context objectForKey:DictionaryApplicationContextKeywords[ApplicationContextCircularFlag]] boolValue];
		NSDictionary* resources = [context objectForKey:DictionaryApplicationContextKeywords[ApplicationContextResourceSection]];
		if (resources) [self setResources:resources];
		
		///
		objectsCfg = [[context objectForKey:DictionaryApplicationContextKeywords[ApplicationContextObjectsSection]] mutableCopy];
		
		/// Check if the user setup a cache
		if (!singletons) {
			self.cache = [[DictionaryCache alloc] init];
		}
	}
	
	return self;
}

- (void)dealloc {
	self.objects = nil;
	self.cache = nil;
}

#pragma mark - Public methods

-(void) mergeWithContext:(id<IApplicationContext>) applicationContext {
	if (![applicationContext isKindOfClass:[DictionaryApplicationContext class]]) 
		return;
	
	DictionaryApplicationContext* srcCtx = (DictionaryApplicationContext*) applicationContext;
	
	[objectsCfg addEntriesFromDictionary:srcCtx.objects];
}

-(BOOL) configureObject:(NSObject*) objectInstance withName:(NSString*) objectName {
	NSDictionary* objectConfiguration = [objectsCfg objectForKey:objectName];
	if (!objectConfiguration) {
		return NO;
	}
	
	NSDictionary* cfg = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectProperties]];
	if (!cfg) return YES;
	
	return [self configureObject:objectInstance 
						withName:objectName 
				andConfiguration:cfg];
}

-(id) getObjectWithName:(NSString*) objectName andDefinition:(NSDictionary*) objectDefinition {
	if (!objectsCfg) return nil;
	
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
	BOOL singleton = [[objectDefinition objectForKey:DictionaryApplicationContextKeywords[ObjectSingleton]] boolValue];
	
	__strong id objectInstance = nil;
	if (singleton) {
		/// Its a singleton, get it from the cache
		objectInstance = [singletons elementForKey:objectName];
	}
	else {
		/// Just create a new instance
		objectInstance = [self createObject:objectName 
						  withConfiguration:objectDefinition];
	}
	
	return objectInstance;
}

-(id) getObjectWithName:(NSString *)objectName {
	if (!objectsCfg) return nil;
	
	NSDictionary* objectCfg = [objectsCfg objectForKey:objectName];
	if (!objectCfg) return nil;
	
	return [self getObjectWithName:objectName 
					 andDefinition:objectCfg];
}

@end

@implementation DictionaryApplicationContext (Private)

-(void) setResources:(NSDictionary*) resources {
	NSArray* includes = [resources objectForKey:DictionaryApplicationContextKeywords[ApplicationContextIncludes]];
	if (includes) {
		for (NSString* include in includes) {
			NSString* resolved = [ApplicationContextResourceProvider resolveFilepath:include];
			if (resolved) {
				id<IApplicationContext> ctx = [IApplicationContext ApplicationContextFromFilepath:resolved];
				if (ctx) [self mergeWithContext:ctx];
			}
		}
	}
}

-(BOOL) configureObject:(NSObject*) objectInstance withName:(const NSString *)objectName andConfiguration:(NSDictionary*) objectConfiguration {
	/// Configuration
	if (![objectConfiguration count]) {
		return YES;
	}
	
	NSMutableDictionary* keyValues = [NSMutableDictionary dictionary];
	for (NSString* key in [objectConfiguration allKeys]) {
		id value = [self getValue:[objectConfiguration objectForKey:key]];
		if (value) {
			[keyValues setObject:value  
						  forKey:key];			
		}
	}
	
	/// Now configure the left over
	[objectInstance setValuesForKeysWithDictionary:keyValues];
	
	return YES;
}

-(id) getValue:(id) cfgValue {
	if (!cfgValue) return nil;
	
	if ([cfgValue isKindOfClass:[NSDictionary class]]) {
		NSDictionary* cfg = (NSDictionary*) cfgValue;
		/// Check if we have a nested object, if not, this a simple dictionary
		if ([cfg objectForKey:DictionaryApplicationContextKeywords[ObjectPropertyNestedObject]]) {
			return [self createObject:[NSString stringWithFormat:@"%d", cfg.hash] 
					withConfiguration:[cfg objectForKey:DictionaryApplicationContextKeywords[ObjectPropertyNestedObject]]];			
		}
		else {
			NSMutableDictionary* value = [NSMutableDictionary dictionary];
			for (NSString* key in cfg) {
				[value setObject:[self getValue:[cfg objectForKey:key]] 
						  forKey:key];
			}
			
			return value;
		}
	}
	else if ([cfgValue isKindOfClass:[NSArray class]]) {
		NSArray* cfg = (NSArray*) cfgValue;
		NSMutableArray* value = [NSMutableArray array];
		for (id val in cfg) {
			[value addObject:[self getValue:val]];
		}
		
		return value;
	}
	
	if ([cfgValue isKindOfClass:[NSString class]]) {
		BOOL isRef = [cfgValue hasPrefix:@"@"];
		BOOL isString = [cfgValue hasPrefix:@"@@"];
		
		if (isRef && !isString) {
			return [self getObjectWithName:[cfgValue substringFromIndex:1]];
		}
		
		return (isString) ? [cfgValue substringFromIndex:1] : cfgValue;
	}
	
	return cfgValue;
}

-(id) createObject:(NSString*) objectName withConfiguration:(NSDictionary*) objectConfiguration {
	NSString* classType = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectType]];
	if (!classType) return nil;
	
	Class c = NSClassFromString(classType);
	if (!c) return nil;

	BOOL initialized = NO;
	id __strong objectInstance = nil;

	/// Check if its a lazy object
	BOOL lazy = [[objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectLazy]] boolValue];
	if (lazy) {
		objectInstance = [[LazyObjectProxy alloc] initWithObjectDefinition:objectConfiguration 
																	  name:objectName
																andContext:self];
		initialized = YES;
	}
	else {
		NSString* factoryMethod = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectFactoryMethod]];
		if (factoryMethod) {
			SEL factoryMethodSelector = NSSelectorFromString(factoryMethod);
			NSInvocation* invocation = nil;
			id target;
			
			NSString* factoryObject = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectFactoryObject]];
			if (!factoryObject) {
				NSMethodSignature* signature = [c methodSignatureForSelector:factoryMethodSelector];
				if (!signature) return nil;
				
				invocation = [NSInvocation invocationWithMethodSignature:signature];
				target = c;
			}
			else {
				Class objectFactory = NSClassFromString(factoryObject);
				if (!objectFactory) {
					return nil;
				}
				
				NSMethodSignature* signature = [objectFactory methodSignatureForSelector:factoryMethodSelector];
				if (!signature) return nil;
				
				invocation = [NSInvocation invocationWithMethodSignature:signature];
				target = objectFactory;
			}
			
			invocation.selector = factoryMethodSelector;
			[invocation invokeWithTarget:target];
			
			__unsafe_unretained NSObject* returnedObject = nil;
			[invocation getReturnValue:&returnedObject];
			objectInstance = returnedObject;
			
			initialized = YES;
		}
		else {
			objectInstance = [c alloc];
		}		
	}
		
	/// Add to the context
	[DependencyTree pushInstance:objectInstance 
				   forObjectName:objectName];
	
	if (!initialized) {
		/// Initialization
		NSDictionary* initialization = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectInitSection]];
		if (initialization) {
			NSString* stringSelector = [initialization objectForKey:DictionaryApplicationContextKeywords[ObjectInitSelector]];
			
			SEL selector;
			if (stringSelector) {
				selector = NSSelectorFromString(stringSelector);
			}
			
			if (selector) {
				NSMethodSignature* signature = [objectInstance methodSignatureForSelector:selector];
				if (!signature) {
					[DependencyTree pop];
					return nil;
				}
				
				NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
				
				NSArray* arguments = [initialization objectForKey:DictionaryApplicationContextKeywords[ObjectInitArguments]];
				NSInteger argumentIndex = 2;
				for (id argument in arguments) {
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
	
	if (objectInstance && !lazy) {
				/// Configure
		NSDictionary* objProperties = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectProperties]];
		if ((objProperties) && ![self configureObject:objectInstance 
											 withName:objectName 
									 andConfiguration:objProperties]) {
			objectInstance = nil;
		}
	}
	
	[DependencyTree pop];

	return objectInstance;
}

-(id) cache:(id<ICache>)cache requestInstanceForKey:(NSString*) objectName {
	/// Get the object configuration
	NSDictionary* objectCfg = [objectsCfg objectForKey:objectName];
	if (!objectCfg) return nil;
	
	return [self createObject:objectName 
			withConfiguration:objectCfg];
}

-(BOOL) cacheShouldRemoveAllElements:(id<ICache>)cache {
	return YES;
}

@end