//
//  XmlAppCtxListHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-29.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxListHandler.h"

#import "DictionaryApplicationContext.h"
#import "XmlAppCtxObjectPropertyHandler.h"
#import "XmlAppCtxObjectHandler.h"
#import "XmlAppCtxContainerEntryHandler.h"
#import "XmlAppCtxObjectsHandler.h"

#import "ObjectDefinition.h"
#import "ObjectInitDefinition.h"
#import "ObjectValueDefinition.h"

@implementation XmlAppCtxListHandler

#pragma mark - Properties

@synthesize list, objectDefinition;

#pragma mark - Init/Dealloc

-(void)dealloc {
	list = nil;
	objectDefinition = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxContainerEntryHandler class], @"entry", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	NSString* objectID = [attributeDict objectForKey:@"id"];
	if (!objectID) {
		objectID = [attributeDict objectForKey:@"name"];
	}
	
	if (!objectID) {	
		if (((![self.parent isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) && 
			 (![self.parent isKindOfClass:[XmlAppCtxObjectArgumentHandler class]])) ||
			([self.parent isKindOfClass:[XmlAppCtxObjectsHandler class]])) {
			return NO;
		}
		
		list = [NSMutableArray array];
	}
	else {
		list = [NSMutableArray array];

		objectDefinition = [[ObjectDefinition alloc] init];
		
		objectDefinition.name = objectID;
		objectDefinition.type = NSStringFromClass([NSArray class]);
		objectDefinition.initializer = [[ObjectInitDefinition alloc] init];
		objectDefinition.initializer.selector = @"initWithArray:";
		
		
		ObjectValueDefinition* initArg = [[ObjectValueDefinition alloc] init];
		initArg.type = ObjectValueTypeList;
		initArg.value = list;
		
		[objectDefinition.initializer.arguments addObject:initArg];
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}

-(void)didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(XmlAppCtxContainerEntryHandler*)handler {
	[list addObject:handler.valueDefinition];
}

@end
