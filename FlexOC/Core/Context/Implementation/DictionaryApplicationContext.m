//
//  DictionaryApplicationContext.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "DictionaryApplicationContext.h"

#import "IApplicationContext.h"
#import "ApplicationContextResourceProvider.h"
#import "LazyObjectProxy.h"
#import "DependencyTree.h"

#import "ObjectDefinition.h"
#import "ObjectFactoryDefinition.h"
#import "ObjectInitDefinition.h"
#import "ObjectValueDefinition.h"

typedef enum {
	ApplicationContextKey,
	ApplicationContextIncludes,
	ApplicationContextCircularFlag,
	ApplicationContextObjectsSection,
	ApplicationContextResourceSection,
	ObjectType,
	ObjectSingleton,
	ObjectLazy,
	ObjectProperties,
	ObjectPropertyReference,
	ObjectPropertyValue,
	ObjectPropertyNestedObject,
	ObjectPropertyNestedDictionary,	
	ObjectFactoryMethod,
	ObjectFactoryObject,
	ObjectInitSection,
	ObjectInitSelector,
	ObjectInitArguments,
	ObjectInitArgumentReference = ObjectPropertyReference,
	ObjectInitArgumentValue = ObjectPropertyValue,
} DictionaryApplicationContextKeywordIDS;

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

@interface DictionaryApplicationContext (Private)

-(void) setResources:(NSDictionary*) resources;

-(BOOL) setObjectDefinition:(id<IObjectDefinition>) objectDefinition withDictionary:(NSDictionary*) objectConfiguration;
-(id<IObjectFactoryDefinition>) getObjectFactoryDefinitionWithDictionary:(NSDictionary*) objectConfiguration;
-(id<IObjectInitDefinition>) getObjectInitDefinitionWithDictionary:(NSDictionary*) objectConfiguration;
-(id<IObjectValueDefinition>) getValueDefinition:(id) argumentConfiguration;
-(NSMutableDictionary*) getPropertiesDefinitionWithDictionary:(NSDictionary*) objectConfiguration;

@end

@implementation DictionaryApplicationContext

#pragma mark - Init/Dealloc

-(id) initWithDictionary:(NSDictionary *)configuration {
	self = [super init];
	if (self) {
		NSDictionary* context = [configuration objectForKey:DictionaryApplicationContextKeywords[ApplicationContextKey]];
		if (!context) {
			return nil;
		}
		
		///
		super.allowCircularDependencies = [[context objectForKey:DictionaryApplicationContextKeywords[ApplicationContextCircularFlag]] boolValue];
		NSDictionary* resources = [context objectForKey:DictionaryApplicationContextKeywords[ApplicationContextResourceSection]];
		if (resources) [self setResources:resources];
		
		///
		NSDictionary* objects = [context objectForKey:DictionaryApplicationContextKeywords[ApplicationContextObjectsSection]];
		
		for (NSString* objectName in objects) {
			NSDictionary* objectDefinition = [objects objectForKey:objectName];
			
			id<IObjectDefinition> definition = [[ObjectDefinition alloc] init];
			definition.name = objectName;
			
			if ([self setObjectDefinition:definition withDictionary:objectDefinition]) {
				[self addObject:objectName withDefinition:definition];
			}
			
		}
	}
	
	return self;
}

#pragma mark - Public methods

@end

@implementation DictionaryApplicationContext (Private)

-(BOOL) setObjectDefinition:(id<IObjectDefinition>) objectDefinition withDictionary:(NSDictionary*) objectConfiguration {
	/// Behavior
	objectDefinition.isSingleton = [[objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectSingleton]] boolValue];
	objectDefinition.isLazy = [[objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectLazy]] boolValue];
	objectDefinition.type = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectType]];
	
	/// Object factory
	objectDefinition.factory = [self getObjectFactoryDefinitionWithDictionary:objectConfiguration];
	
	/// Object init
	objectDefinition.initializer = [self getObjectInitDefinitionWithDictionary:objectConfiguration];
	
	/// Object Properties
	objectDefinition.properties = [self getPropertiesDefinitionWithDictionary:objectConfiguration];
	
	return YES;
}

-(NSMutableDictionary*) getPropertiesDefinitionWithDictionary:(NSDictionary*) objectConfiguration {
	NSDictionary* objProperties = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectProperties]];
	if (!objProperties) return nil;
	
	NSMutableDictionary* properties = [NSMutableDictionary dictionary];
	for (NSString* property in objProperties) {
		id propertyValue = [objProperties objectForKey:property];
		if (!propertyValue) continue;
		
		id<IObjectValueDefinition> valueDefinition = [self getValueDefinition:propertyValue];
		if (!valueDefinition) continue;
		
		[properties setObject:valueDefinition 
					   forKey:property];
	}
	
	return properties;
}

-(id<IObjectFactoryDefinition>) getObjectFactoryDefinitionWithDictionary:(NSDictionary*) objectConfiguration {
	NSString* factoryMethod = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectFactoryMethod]];
	if (!factoryMethod) return nil;

	/// Set the factory definition
	ObjectFactoryDefinition* factoryDefinition = [[ObjectFactoryDefinition alloc] init];
	factoryDefinition.factoryMethod = factoryMethod;
	factoryDefinition.factoryObject = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectFactoryObject]];
	
	return factoryDefinition;
}

-(id<IObjectInitDefinition>) getObjectInitDefinitionWithDictionary:(NSDictionary*) objectConfiguration {
	NSDictionary* initialization = [objectConfiguration objectForKey:DictionaryApplicationContextKeywords[ObjectInitSection]];
	if (!initialization) return nil;
	
	NSString* stringSelector = [initialization objectForKey:DictionaryApplicationContextKeywords[ObjectInitSelector]];
	if (!stringSelector) return nil;
	
	ObjectInitDefinition* initDefinition = [[ObjectInitDefinition alloc] init];
	initDefinition.selector = stringSelector;
	
	/// Arguments
	NSArray* arguments = [initialization objectForKey:DictionaryApplicationContextKeywords[ObjectInitArguments]];
	for (id argument in arguments) {
		id value = [self getValueDefinition:argument];
		if (value)
			[initDefinition.arguments addObject:value];
	}
	
	return initDefinition;
}

-(id<IObjectValueDefinition>) getValueDefinition:(id) argumentConfiguration {
	if (!argumentConfiguration) return nil;
	
	ObjectValueDefinition* valueDefinition = [[ObjectValueDefinition alloc] init];
	
	if ([argumentConfiguration isKindOfClass:[NSDictionary class]]) {
		NSDictionary* cfg = (NSDictionary*) argumentConfiguration;
		/// Check if we have a nested object, if not, this a simple dictionary
		if ([cfg objectForKey:DictionaryApplicationContextKeywords[ObjectPropertyNestedObject]]) {
			ObjectDefinition* value = [[ObjectDefinition alloc] init];
			value.name = [NSString stringWithFormat:@"%d", cfg.hash];
			[self setObjectDefinition:value 
					   withDictionary:[cfg objectForKey:DictionaryApplicationContextKeywords[ObjectPropertyNestedObject]]];
			
			valueDefinition.type = ObjectValueTypeObject;
			valueDefinition.value = value;
		}
		else {
			NSMutableDictionary* value = [NSMutableDictionary dictionary];
			for (NSString* key in cfg) {
				[value setObject:[self getValueDefinition:[cfg objectForKey:key]] 
						  forKey:key];
			}
			
			valueDefinition.type = ObjectValueTypeDictionary;
			valueDefinition.value = value;
		}
	}
	else if ([argumentConfiguration isKindOfClass:[NSArray class]]) {
		NSArray* cfg = (NSArray*) argumentConfiguration;
		NSMutableArray* value = [NSMutableArray array];
		for (id val in cfg) {
			[value addObject:[self getValueDefinition:val]];
		}
		
		valueDefinition.type = ObjectValueTypeList;
		valueDefinition.value = value;
	}
	else if ([argumentConfiguration isKindOfClass:[NSString class]]) {
		BOOL isRef = [argumentConfiguration hasPrefix:@"@"];
		BOOL isString = [argumentConfiguration hasPrefix:@"@@"];
		
		if (isRef && !isString) {
			valueDefinition.type = ObjectValueTypeReference;
			valueDefinition.value = [argumentConfiguration substringFromIndex:1];
		}
		else {
			valueDefinition.type = ObjectValueTypeValue;
			valueDefinition.value = (isString) ? [argumentConfiguration substringFromIndex:1] : argumentConfiguration;
		}
	}
	else {
		valueDefinition.type = ObjectValueTypeValue;
		valueDefinition.value = argumentConfiguration;		
	}

	return valueDefinition;
}

-(void) setResources:(NSDictionary*) resources {
	NSArray* includes = [resources objectForKey:DictionaryApplicationContextKeywords[ApplicationContextIncludes]];
	if (includes) {
		for (NSString* include in includes) {
			NSString* resolved = [ApplicationContextResourceProvider resolveFilepath:include];
			if (resolved) {
				id<IApplicationContext> ctx = [IApplicationContext ApplicationContextFromLocation:resolved];
				if (ctx) [self mergeWithContext:ctx];
			}
		}
	}
}

@end