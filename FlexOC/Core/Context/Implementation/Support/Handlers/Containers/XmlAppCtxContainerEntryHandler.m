//
//  XmlAppCtxContainerEntryHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-27.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxContainerEntryHandler.h"

#import "XmlAppCtxObjectHandler.h"
#import "XmlAppCtxDictionayHandler.h"
#import "XmlAppCtxListHandler.h"
#import "DictionaryApplicationContext.h"

@implementation XmlAppCtxContainerEntryHandler

#pragma mark - Properties

@synthesize key;

#pragma mark - Init/Dealloc

-(void)dealloc {
	key = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectHandler class], @"object", 
													  [XmlAppCtxDictionayHandler class], @"dictionary", 
													  [XmlAppCtxListHandler class], @"list",
													  nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	
	BOOL needaKey = [super.parent isKindOfClass:[XmlAppCtxDictionayHandler class]];
	if (needaKey) {
		key = [attributeDict objectForKey:@"key"];
		if (!key) {
			return NO;
		}
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}

@end
