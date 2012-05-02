//
//  XmlAppCtxRootHandler.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "XmlAppCtxRootHandler.h"

#import "DictionaryApplicationContext.h"
#import "XmlAppCtxObjectsHandler.h"

@implementation XmlAppCtxRootHandler

- (id)init {
    self = [super init];
    if (self) {
    }
	
    return self;
}

#pragma mark - Override

-(NSDictionary *) supportedElements {
	return [NSDictionary dictionaryWithObjectsAndKeys:[XmlAppCtxObjectsHandler class], @"objects", nil];
}

-(BOOL)beginHandlingElement:(NSString *)elementName withAttribute:(NSDictionary *)attributeDict forParser:(NSXMLParser *)parser {
	
	[self pushNewContextForKey:DictionaryApplicationContextKeywords[ApplicationContextKey]];

	NSString* allowCircularDependencies = [attributeDict objectForKey:@"allowCircularDependencies"];
	if (allowCircularDependencies) {
		[self.context setObject:[NSNumber numberWithBool:[allowCircularDependencies boolValue]] 
						 forKey:DictionaryApplicationContextKeywords[ApplicationContextCircularFlag]];
	}
	
	return [super beginHandlingElement:elementName 
						 withAttribute:attributeDict 
							 forParser:parser];
}
@end