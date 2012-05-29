//
//  XmlAppCtxObjectArgumentHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-23.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxObjectArgumentHandler.h"

#import "ObjectValueDefinition.h"
#import "XmlAppCtxObjectHandler.h"
#import "XmlAppCtxListHandler.h"
#import "XmlAppCtxDictionayHandler.h"

@implementation XmlAppCtxObjectArgumentHandler

#pragma mark - Properties

@synthesize valueDefinition;

#pragma mark - Init/Dealloc

-(id) init {
	self = [super init];
	if (self) {
		valueDefinition = [[ObjectValueDefinition alloc] init];
	}
	
	return self;
}

-(void)dealloc {
	valueDefinition = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectHandler class], @"object", 
			[XmlAppCtxListHandler class], @"list",
			[XmlAppCtxDictionayHandler class], @"dictionary", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	
	NSString* strValue = [attributeDict objectForKey:@"ref"];
	if (strValue) {
		valueDefinition.type = ObjectValueTypeReference;
		valueDefinition.value = strValue;
	}
	else {
		strValue = [attributeDict objectForKey:@"value"];
		if (strValue) {
			valueDefinition.type = ObjectValueTypeValue;
			valueDefinition.value = strValue;
		}
	}
	
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];
}

-(void) didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(id<IXmlApplicationContextParserHandler>)handler {
	if ([handler isKindOfClass:[XmlAppCtxObjectHandler class]]) {
		valueDefinition.type = ObjectValueTypeObject;
		valueDefinition.value = ((XmlAppCtxObjectHandler*) handler).objectDefinition;
	}
	else if ([handler isKindOfClass:[XmlAppCtxListHandler class]]) {
		valueDefinition.type = ObjectValueTypeList;
		valueDefinition.value = ((XmlAppCtxListHandler*) handler).list;
	}
	else if ([handler isKindOfClass:[XmlAppCtxDictionayHandler class]]) {
		valueDefinition.type = ObjectValueTypeDictionary;
		valueDefinition.value = ((XmlAppCtxDictionayHandler*) handler).dictionary;
	}
}


@end
