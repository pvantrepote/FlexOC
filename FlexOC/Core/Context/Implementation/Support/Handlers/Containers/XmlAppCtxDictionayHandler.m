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

@implementation XmlAppCtxDictionayHandler

#pragma mark - Override

-(NSDictionary *)supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxContainerEntryHandler class], @"entry", 
													  [XmlAppCtxObjectInitHandler class], @"init", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	NSString* objectID = [attributeDict objectForKey:@"id"];
	BOOL needAType = YES;
	if (!objectID) {
		if ((![self.parent isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) && 
			(![self.parent isKindOfClass:[XmlAppCtxObjectInitArgumentHandler class]])) {
			return NO;
		}
		
		objectID = (NSString*)DictionaryApplicationContextKeywords[ObjectPropertyNestedDictionary];
		needAType = NO;
		
		if ([self.parent isKindOfClass:[XmlAppCtxObjectInitArgumentHandler class]]) {
			NSMutableArray* args = [self.context objectForKey:DictionaryApplicationContextKeywords[ObjectInitArguments]];
			[args addObject:[NSMutableDictionary dictionary]];
			self.context = [args lastObject];
		}
		else if ([self.parent isKindOfClass:[XmlAppCtxObjectPropertyHandler class]]) {
			[self pushNewContextForKey:((XmlAppCtxObjectPropertyHandler*)self.parent).name];
		}
	}
	else {
		[self pushNewContextForKey:objectID];		
	}
	
	if (needAType) {
		[self.context setObject:NSStringFromClass([NSDictionary class]) 
						 forKey:DictionaryApplicationContextKeywords[ObjectType]];		
		[self pushNewContextForKey:DictionaryApplicationContextKeywords[ObjectInitSection]];
		[self.context setObject:@"initWithDictionary:" 
						 forKey:DictionaryApplicationContextKeywords[ObjectInitSelector]];
		[self pushNewContextForKey:DictionaryApplicationContextKeywords[ObjectInitArguments]];
		
	}
		
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}

@end
