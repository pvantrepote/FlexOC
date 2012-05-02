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

@implementation XmlAppCtxListHandler

#pragma mark - Properties

@synthesize list;

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
			[args addObject:[NSMutableArray array]];
			list = [args lastObject];
		}
		else {
			[self.context setObject:[NSMutableArray array] 
							 forKey:((XmlAppCtxObjectPropertyHandler*)self.parent).name];
			list = [self.context objectForKey:((XmlAppCtxObjectPropertyHandler*)self.parent).name];
		}
	}
	else {
		[self pushNewContextForKey:objectID];		
	}
	
	if (needAType) {
		[self.context setObject:NSStringFromClass([NSArray class]) 
						 forKey:DictionaryApplicationContextKeywords[ObjectType]];		
		[self pushNewContextForKey:DictionaryApplicationContextKeywords[ObjectInitSection]];
		[self.context setObject:@"initWithArray:" 
						 forKey:DictionaryApplicationContextKeywords[ObjectInitSelector]];
		
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}


@end
