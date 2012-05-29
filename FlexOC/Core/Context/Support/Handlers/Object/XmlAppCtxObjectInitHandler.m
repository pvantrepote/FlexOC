//
//  XmlAppCtxObjectInitHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-23.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxObjectInitHandler.h"

#import "XmlAppCtxObjectPropertyHandler.h"
#import "DictionaryApplicationContext.h"
#import "XmlAppCtxDictionayHandler.h"
#import "XmlAppCtxListHandler.h"
#import "XmlAppCtxContainerEntryHandler.h"
#import "XmlAppCtxObjectHandler.h"
#import "XmlAppCtxObjectArgumentHandler.h"

#import "ObjectInitDefinition.h"
#import "ObjectValueDefinition.h"

@implementation XmlAppCtxObjectInitHandler

#pragma mark - Properties

@synthesize initDefinition;

#pragma mark - Init/Dealloc

-(id) init {
	self = [super init];
	if (self) {
		initDefinition = [[ObjectInitDefinition alloc] init];
	}
	
	return self;
}

-(void)dealloc {
	initDefinition = nil;
}

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectArgumentHandler class], @"argument", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	NSString* selector = [attributeDict objectForKey:@"selector"];
	if (!selector) return NO;
	
	initDefinition.selector = selector;
		
	return [super beginHandlingElement:elementName withAttribute:attributeDict forParser:parser];
}

-(void)didEndHandlingElement:(NSString *)elementName forParser:(NSXMLParser *)parser withHandler:(XmlAppCtxObjectArgumentHandler*)handler {
	[initDefinition.arguments addObject:handler.valueDefinition];
}

@end