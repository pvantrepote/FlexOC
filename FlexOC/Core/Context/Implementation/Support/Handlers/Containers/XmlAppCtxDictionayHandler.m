//
//  XmlAppCtxDictionayHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-27.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxDictionayHandler.h"

#import "DictionaryApplicationContext.h"
#import "XmlAppCtxObjectPropertyHandler.h"
#import "XmlAppCtxObjectHandler.h"
#import "XmlAppCtxContainerEntryHandler.h"
#import "XmlAppCtxObjectsHandler.h"

#import "ObjectDefinition.h"
#import "ObjectInitDefinition.h"
#import "ObjectValueDefinition.h"

@implementation XmlAppCtxDictionayHandler

#pragma mark - Properties

@synthesize dictionary, objectDefinition;

#pragma mark - Init/Dealloc

-(void)dealloc {
	dictionary = nil;
	objectDefinition = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxContainerEntryHandler class], @"entry", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	NSString* objectID = [attributeDict objectForKey:@"id"];
	if (!objectID) {
		objectID = [attributeDict objectForKey:@""];
		if (((![self.parent isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) && 
			 (![self.parent isKindOfClass:[XmlAppCtxObjectArgumentHandler class]])) ||
			([self.parent isKindOfClass:[XmlAppCtxObjectsHandler class]])) {
			return NO;
		}
		
		dictionary = [NSMutableDictionary dictionary];	
	}
	else {
		dictionary = [NSMutableDictionary dictionary];	
		
		objectDefinition = [[ObjectDefinition alloc] init];
		
		objectDefinition.name = objectID;
		objectDefinition.type = NSStringFromClass([NSArray class]);
		objectDefinition.initializer = [[ObjectInitDefinition alloc] init];
		objectDefinition.initializer.selector = @"initWithDictionary:";
		
		
		ObjectValueDefinition* initArg = [[ObjectValueDefinition alloc] init];
		initArg.type = ObjectValueTypeList;
		initArg.value = dictionary;
		
		[objectDefinition.initializer.arguments addObject:initArg];
		
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}

-(void)didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(XmlAppCtxContainerEntryHandler*)handler {
	if (!handler.key) return;
	
	[dictionary setObject:handler.valueDefinition 
				   forKey:handler.key];
}

@end
