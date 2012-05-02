//
//  XmlAppCtxObjectPropertyHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-24.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxObjectPropertyHandler.h"

#import "XmlAppCtxObjectHandler.h"
#import "DictionaryApplicationContext.h"
#import "XmlAppCtxDictionayHandler.h"
#import "XmlAppCtxListHandler.h"

@implementation XmlAppCtxObjectPropertyHandler

#pragma mark - Properties

@synthesize name;

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectHandler class], @"object", 
			[XmlAppCtxListHandler class], @"list",
			[XmlAppCtxDictionayHandler class], @"dictionary", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	name = [attributeDict objectForKey:@"name"];
	if (!name) return NO;
	
	self.context = [self.context objectForKey:DictionaryApplicationContextKeywords[ObjectProperties]];
	
	NSString* value = [attributeDict objectForKey:@"ref"];
	if (value) {
		value = [NSString stringWithFormat:@"@%@", value];
	}
	else {
		value = [attributeDict objectForKey:@"value"];
		
		if ([value hasPrefix:@"@"]) {
			value = [NSString stringWithFormat:@"@%@", value];
		}
	}
	if (value) {
		[self.context setObject:value forKey:name];		
	}
	
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];
}

@end