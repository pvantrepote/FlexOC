//
//  XmlAppCtxObjectsHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxObjectsHandler.h"

#import "XmlAppCtxObjectHandler.h"
#import "DictionaryApplicationContext.h"

@implementation XmlAppCtxObjectsHandler

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectHandler class], @"object", nil];
}

-(BOOL) beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	[self pushNewContextForKey:DictionaryApplicationContextKeywords[ApplicationContextObjectsSection]];

	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];
}



@end
