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

@implementation XmlAppCtxObjectHandler

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectPropertyHandler class], @"property", 
													  [XmlAppCtxObjectInitHandler class], @"init", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	NSString* objectID = [attributeDict objectForKey:@"id"];
	if (!objectID) {
		if ((![self.parent isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) && 
			(![self.parent isKindOfClass:[XmlAppCtxObjectInitArgumentHandler class]]) &&
			(![self.parent isKindOfClass:[XmlAppCtxContainerEntryHandler class]])) {
			return NO;
		}
		
		objectID = (NSString*)DictionaryApplicationContextKeywords[ObjectPropertyNestedObject];
		if ([self.parent isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) {
			[self pushNewContextForKey:((XmlAppCtxObjectPropertyHandler*)self.parent).name];
		}
		else if ([self.parent isKindOfClass:[XmlAppCtxObjectInitArgumentHandler class]]) {
			NSMutableArray* args = [self.context objectForKey:DictionaryApplicationContextKeywords[ObjectInitArguments]];
			[args addObject:[NSMutableDictionary dictionary]];
			self.context = [args lastObject];
		}
	}
	
	NSString* type = [attributeDict objectForKey:@"type"];
	if (!type) return NO;
	
	[self pushNewContextForKey:objectID];
	
	[self.context setObject:type 
					 forKey:DictionaryApplicationContextKeywords[ObjectType]];
	[self.context setObject:[NSMutableDictionary dictionary] 
					 forKey:DictionaryApplicationContextKeywords[ObjectProperties]];
	NSString* singleton = [attributeDict objectForKey:@"singleton"];
	if (singleton) {
		[self.context  setObject:[NSNumber numberWithBool:[singleton boolValue]] 
						  forKey:DictionaryApplicationContextKeywords[ObjectSingleton]];
	}
	NSString* lazy = [attributeDict objectForKey:@"lazy"];
	if (lazy) {
		[self.context  setObject:[NSNumber numberWithBool:[lazy boolValue]] 
						  forKey:DictionaryApplicationContextKeywords[ObjectLazy]];		
	}
	
	NSString* factoryMethod = [attributeDict objectForKey:@"factory-method"];
	if (factoryMethod) {
		[self.context  setObject:factoryMethod 
						  forKey:DictionaryApplicationContextKeywords[ObjectFactoryMethod]];
		NSString* factoryObject = [attributeDict 
								   objectForKey:@"factory-object"];
		if (factoryObject) {
			[self.context  setObject:factoryObject 
							  forKey:DictionaryApplicationContextKeywords[ObjectFactoryObject]];
		}
	}
	
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];	
}


@end

@implementation XmlAppCtxObjectInitHandler

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectInitArgumentHandler class], @"argument", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	
	[self pushNewContextForKey:DictionaryApplicationContextKeywords[ObjectInitSection]];
	
	NSString* selector = [attributeDict objectForKey:@"selector"];
	if (selector) {
		[self.context setObject:selector 
						forKey:DictionaryApplicationContextKeywords[ObjectInitSelector]];
	}
	
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];
}

@end

@implementation XmlAppCtxObjectInitArgumentHandler 

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectHandler class], @"object", 
													  [XmlAppCtxListHandler class], @"list",
													  [XmlAppCtxDictionayHandler class], @"dictionary", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	
	NSString* value = [attributeDict objectForKey:@"value"];
	NSString* ref = [attributeDict objectForKey:@"ref"];	
	
	NSMutableArray* args = [self.context objectForKey:DictionaryApplicationContextKeywords[ObjectInitArguments]];
	if (!args) {
		args = [NSMutableArray array];
		[self.context setObject:args forKey:DictionaryApplicationContextKeywords[ObjectInitArguments]];
	}
	
	if (value || ref) {
		NSString* arg = (ref || [value hasPrefix:@"@"]) ? [NSString stringWithFormat:@"@%@", (ref) ? ref : value] : value;
		[args addObject:arg];
	}
	
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];
}

@end
