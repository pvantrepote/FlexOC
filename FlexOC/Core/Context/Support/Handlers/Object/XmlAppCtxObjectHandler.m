//
//  XmlAppCtxObjectHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-22.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxObjectHandler.h"

#import "XmlAppCtxObjectPropertyHandler.h"
#import "DictionaryApplicationContext.h"
#import "XmlAppCtxDictionayHandler.h"
#import "XmlAppCtxListHandler.h"
#import "XmlAppCtxContainerEntryHandler.h"
#import "XmlAppCtxObjectInitHandler.h"
#import "ObjectDefinition.h"
#import "ObjectFactoryDefinition.h"

@implementation XmlAppCtxObjectHandler

#pragma mark - Properties

@synthesize objectDefinition;

#pragma mark - Init/Dealloc

-(id)init {
	self = [super init];
	if (self) {
	}
	
	return self;
}

-(void)dealloc {
	self.objectDefinition = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectPropertyHandler class], @"property", 
													  [XmlAppCtxObjectInitHandler class], @"init", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	NSString* objectID = [attributeDict objectForKey:@"id"];
	if (!objectID) {
		objectID = [attributeDict objectForKey:@"name"];
	}

	if (!objectID) {
		if ((![self.parent isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) && 
			(![self.parent isKindOfClass:[XmlAppCtxObjectArgumentHandler class]]) &&
			(![self.parent isKindOfClass:[XmlAppCtxContainerEntryHandler class]])) {
			return NO;
		}
	}
		
	NSString* type = [attributeDict objectForKey:@"type"];
	if (!type) return NO;
	
	objectDefinition = [[ObjectDefinition alloc] init];
	objectDefinition.name = objectID;
	objectDefinition.type = type;
	
	NSString* singleton = [attributeDict objectForKey:@"singleton"];
	if (singleton) {
		objectDefinition.isSingleton = [singleton boolValue];
	}
	
	NSString* lazy = [attributeDict objectForKey:@"lazy"];
	if (lazy) {
		objectDefinition.isLazy = [lazy boolValue];
	}

	NSString* factoryMethod = [attributeDict objectForKey:@"factory-method"];
	if (factoryMethod) {
		NSString* factoryObject = [attributeDict objectForKey:@"factory-object"];

		objectDefinition.factory = [[ObjectFactoryDefinition alloc] init];
		
		objectDefinition.factory.factoryMethod = factoryMethod;
		if (factoryObject) {
			objectDefinition.factory.factoryObject = factoryObject;
		}
	}
	
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];	
}

-(void)didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(id<IXmlApplicationContextParserHandler>)handler {
	if ([handler isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) {
		if (!objectDefinition.properties) {
			objectDefinition.properties = [NSMutableDictionary dictionary];
		}
		
		XmlAppCtxObjectPropertyHandler* prop = (XmlAppCtxObjectPropertyHandler*) handler;
		[objectDefinition.properties setObject:prop.valueDefinition
										forKey:prop.name];
	}
	else if ([handler isKindOfClass:[XmlAppCtxObjectInitHandler class]]) {
		XmlAppCtxObjectInitHandler* prop = (XmlAppCtxObjectInitHandler*) handler;
		objectDefinition.initializer = prop.initDefinition;
	}
}

@end
